#!/bin/bash
script="cis_cnvlinux.sh"
rm -f detalleValidacionHardening*html reporteValidacionHardening*csv
./$script > /dev/null 2>&1
