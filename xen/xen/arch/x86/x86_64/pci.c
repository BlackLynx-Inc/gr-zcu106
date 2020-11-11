/******************************************************************************
 * pci.c
 * 
 * Architecture-dependent PCI access functions.
 */

#include <xen/spinlock.h>
#include <xen/pci.h>
#include <asm/io.h>

#define PCI_CONF_ADDRESS(sbdf, reg) \
    (0x80000000 | ((sbdf).bdf << 8) | ((reg) & ~3))

uint8_t pci_conf_read8(pci_sbdf_t sbdf, unsigned int reg)
{
    uint32_t value;

    if ( sbdf.seg || reg > 255 )
    {
        pci_mmcfg_read(sbdf.seg, sbdf.bus, sbdf.devfn, reg, 1, &value);
        return value;
    }

    return pci_conf_read(PCI_CONF_ADDRESS(sbdf, reg), reg & 3, 1);
}

uint16_t pci_conf_read16(pci_sbdf_t sbdf, unsigned int reg)
{
    if ( sbdf.seg || reg > 255 )
    {
        uint32_t value;

        pci_mmcfg_read(sbdf.seg, sbdf.bus, sbdf.devfn, reg, 2, &value);
        return value;
    }

    return pci_conf_read(PCI_CONF_ADDRESS(sbdf, reg), reg & 2, 2);
}

uint32_t pci_conf_read32(pci_sbdf_t sbdf, unsigned int reg)
{
    if ( sbdf.seg || reg > 255 )
    {
        uint32_t value;

        pci_mmcfg_read(sbdf.seg, sbdf.bus, sbdf.devfn, reg, 4, &value);
        return value;
    }

    return pci_conf_read(PCI_CONF_ADDRESS(sbdf, reg), 0, 4);
}

void pci_conf_write8(pci_sbdf_t sbdf, unsigned int reg, uint8_t data)
{
    if ( sbdf.seg || reg > 255 )
        pci_mmcfg_write(sbdf.seg, sbdf.bus, sbdf.devfn, reg, 1, data);
    else
        pci_conf_write(PCI_CONF_ADDRESS(sbdf, reg), reg & 3, 1, data);
}

void pci_conf_write16(pci_sbdf_t sbdf, unsigned int reg, uint16_t data)
{
    if ( sbdf.seg || reg > 255 )
        pci_mmcfg_write(sbdf.seg, sbdf.bus, sbdf.devfn, reg, 2, data);
    else
        pci_conf_write(PCI_CONF_ADDRESS(sbdf, reg), reg & 2, 2, data);
}

void pci_conf_write32(pci_sbdf_t sbdf, unsigned int reg, uint32_t data)
{
    if ( sbdf.seg || reg > 255 )
        pci_mmcfg_write(sbdf.seg, sbdf.bus, sbdf.devfn, reg, 4, data);
    else
        pci_conf_write(PCI_CONF_ADDRESS(sbdf, reg), 0, 4, data);
}
