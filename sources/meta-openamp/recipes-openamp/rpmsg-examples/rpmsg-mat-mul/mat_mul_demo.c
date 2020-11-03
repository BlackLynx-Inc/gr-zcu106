/*
 * Sample demo application that showcases inter processor
 * communication from linux userspace to a remote software
 * context. The application generates random matrices and
 * transmits them to the remote context over rpmsg. The
 * remote application performs multiplication of matrices
 * and transmits the results back to this application.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <time.h>
#include <fcntl.h>
#include <pthread.h>
#include <string.h>
#include <linux/rpmsg.h>

#define MATRIX_SIZE 6

struct _matrix {
	unsigned int size;
	unsigned int elements[MATRIX_SIZE][MATRIX_SIZE];
};

static void matrix_print(struct _matrix *m)
{
	int i, j;

	/* Generate two random matrices */
	printf(" \r\n Master : Linux : Printing results \r\n");

	for (i = 0; i < m->size; ++i) {
		for (j = 0; j < m->size; ++j)
			printf(" %d ", (unsigned int)m->elements[i][j]);
		printf("\r\n");
	}
}

static void generate_matrices(int num_matrices,
				unsigned int matrix_size, void *p_data)
{
	int	i, j, k;
	struct _matrix *p_matrix = p_data;
	time_t	t;
	unsigned long value;

	srand((unsigned) time(&t));

	for (i = 0; i < num_matrices; i++) {
		/* Initialize workload */
		p_matrix[i].size = matrix_size;

		printf(" \r\n Master : Linux : Input matrix %d \r\n", i);
		for (j = 0; j < matrix_size; j++) {
			printf("\r\n");
			for (k = 0; k < matrix_size; k++) {

				value = (rand() & 0x7F);
				value = value % 10;
				p_matrix[i].elements[j][k] = value;
				printf(" %d ",
				(unsigned int)p_matrix[i].elements[j][k]);
			}
		}
		printf("\r\n");
	}

}

static pthread_t ui_thread, compute_thread;
static pthread_mutex_t sync_lock;

static int charfd = -1, fd, compute_flag;
static int ntimes = 1;
static struct _matrix i_matrix[2];
static struct _matrix r_matrix;

#define RPMSG_GET_KFIFO_SIZE 1
#define RPMSG_GET_FREE_SPACE 3

void *ui_thread_entry(void *ptr)
{
	int cmd, ret, i;

	for (i=0; i < ntimes; i++){
		printf("\r\n **********************************");
		printf("****\r\n");
		printf("\r\n  Matrix multiplication demo Round %d \r\n", i);
		printf("\r\n **********************************");
		printf("****\r\n");
		compute_flag = 1;
		pthread_mutex_unlock(&sync_lock);

		printf("\r\n Compute thread unblocked .. \r\n");
		printf(" The compute thread is now blocking on");
		printf("a read() from rpmsg device \r\n");
		printf("\r\n Generating random matrices now ... \r\n");

		generate_matrices(2, 6, i_matrix);

		printf("\r\n Writing generated matrices to rpmsg ");
		printf("rpmsg device, %d bytes .. \r\n",
				sizeof(i_matrix));

		write(fd, i_matrix, sizeof(i_matrix));

		/* adding this so the threads
		dont overlay the strings they print */
		sleep(1);
		printf("\r\nEnd of Matrix multiplication demo Round %d \r\n", i);
	}

	compute_flag = 0;
	pthread_mutex_unlock(&sync_lock);
	printf("\r\n Quitting application .. \r\n");
	printf(" Matrix multiplication demo end \r\n");

	return 0;
}

void *compute_thread_entry(void *ptr)
{
	int bytes_rcvd;

	pthread_mutex_lock(&sync_lock);

	while (compute_flag == 1) {

		do {
			bytes_rcvd = read(fd, &r_matrix, sizeof(r_matrix));
		} while ((bytes_rcvd < sizeof(r_matrix)) || (bytes_rcvd < 0));

		printf("\r\n Received results! - %d bytes from ", bytes_rcvd);
		printf("rpmsg device (transmitted from remote context) \r\n");

		matrix_print(&r_matrix);

		pthread_mutex_lock(&sync_lock);
	}

	return 0;
}

int rpmsg_create_ept(int rpfd, struct rpmsg_endpoint_info *eptinfo)
{
	int ret;

	ret = ioctl(rpfd, RPMSG_CREATE_EPT_IOCTL, eptinfo);
	if (ret)
		perror("Failed to create endpoint.\n");
	return ret;
}

char *get_rpmsg_ept_dev_name(char *rpmsg_char_name, char *ept_name,
			     char *ept_dev_name)
{
	char sys_rpmsg_ept_name_path[64];
	char svc_name[64];
	char *sys_rpmsg_path = "/sys/class/rpmsg";
	FILE *fp;
	int i;
	int ept_name_len;

	for (i = 0; i < 128; i++) {
		sprintf(sys_rpmsg_ept_name_path, "%s/%s/rpmsg%d/name",
			sys_rpmsg_path, rpmsg_char_name, i);
		printf("checking %s\n", sys_rpmsg_ept_name_path);
		fp = fopen(sys_rpmsg_ept_name_path, "r");
		if (!fp) {
			printf("failed to open %s\n", sys_rpmsg_ept_name_path);
			break;
		}
		fgets(svc_name, sizeof(svc_name), fp);
		fclose(fp);
		printf("svc_name: %s.\n",svc_name);
		ept_name_len = strlen(ept_name);
		if (ept_name_len > sizeof(svc_name))
			ept_name_len = sizeof(svc_name);
		if (!strncmp(svc_name, ept_name, ept_name_len)) {
			sprintf(ept_dev_name, "rpmsg%d", i);
			return ept_dev_name;
		}
	}

	printf("Not able to RPMsg endpoint file for %s:%s.\n",
	       rpmsg_char_name, ept_name);
	return NULL;
}

int main(int argc, char *argv[])
{
	unsigned int size;
	int opt;
	char *rpmsg_dev="/dev/rpmsg0";
	char *rpmsg_char_name;
	struct rpmsg_endpoint_info eptinfo;

	while ((opt = getopt(argc, argv, "d:n:")) != -1) {
		switch (opt) {
		case 'd':
			rpmsg_dev = optarg;
			break;
		case 'n':
			ntimes = atoi(optarg);
			break;
		default:
			printf("getopt return unsupported option: -%c\n",opt);
			break;
		}
	}
	printf("\r\n Matrix multiplication demo start \r\n");

	printf("\r\n Open rpmsg dev %s! \r\n", rpmsg_dev);

	fd = open(rpmsg_dev, O_RDWR);
	if (fd < 0) {
		perror("Failed to open rpmsg device.\n");
		return -1;
	}

	rpmsg_char_name = strstr(rpmsg_dev, "rpmsg_ctrl");
	if (rpmsg_char_name != NULL) {
		char ept_dev_name[16];
		char ept_dev_path[32];
		int ret;

		strcpy(eptinfo.name, "rpmsg-openamp-demo-channel");
		eptinfo.src = 0;
		eptinfo.dst = 0xFFFFFFFF;
		ret = rpmsg_create_ept(fd, &eptinfo);
		if (ret) {
			printf("failed to create RPMsg endpoint.\n");
			return -1;
		}
		charfd = fd;

		if (!get_rpmsg_ept_dev_name(rpmsg_char_name, eptinfo.name,
					   ept_dev_name))
			return -1;
		sprintf(ept_dev_path, "/dev/%s", ept_dev_name);
		fd = open(ept_dev_path, O_RDWR | O_NONBLOCK);
		if (fd < 0) {
			perror("Failed to open rpmsg device.");
			close(charfd);
			return -1;
		}
	}

	if (pthread_mutex_init(&sync_lock, NULL) != 0)
		printf("\r\n mutex initialization failure \r\n");

	pthread_mutex_lock(&sync_lock);

	printf("\r\n Creating ui_thread and compute_thread ... \r\n");

	pthread_create(&ui_thread, NULL, &ui_thread_entry, "ui_thread");

	pthread_create(&compute_thread, NULL, &compute_thread_entry,
				"compute_thread");
	pthread_join(ui_thread, NULL);

	pthread_join(compute_thread, NULL);

	close(fd);
	if (charfd >= 0)
		close(charfd);

	printf("\r\n Quitting application .. \r\n");
	printf(" Matrix multiply application end \r\n");

	pthread_mutex_destroy(&sync_lock);

	return 0;
}
