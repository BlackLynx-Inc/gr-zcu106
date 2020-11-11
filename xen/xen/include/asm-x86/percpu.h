#ifndef __X86_PERCPU_H__
#define __X86_PERCPU_H__

#ifndef __ASSEMBLY__
extern char __per_cpu_start[], __per_cpu_data_end[];
extern unsigned long __per_cpu_offset[NR_CPUS];
void percpu_init_areas(void);
#endif

/* var is in discarded region: offset to particular copy we want */
#define per_cpu(var, cpu)  \
    (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
#define this_cpu(var) \
    (*RELOC_HIDE(&per_cpu__##var, get_cpu_info()->per_cpu_offset))

#define this_cpu_ptr(var) \
    (*RELOC_HIDE(var, get_cpu_info()->per_cpu_offset))

#define per_cpu_ptr(var, cpu)  \
    (*RELOC_HIDE(var, __per_cpu_offset[cpu]))

#endif /* __X86_PERCPU_H__ */
