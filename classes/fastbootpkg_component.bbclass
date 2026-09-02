addtask populate_fastbootpkg_components after do_build
do_populate_fastbootpkg_components[doc] = "Exports artifacts that the recipe wants to place into the final fastboot package"
do_populate_fastbootpkg_components() {
    # current directory is set by [dirs] varflag
    for f in ${FASTBOOTPKG_COMPONENTS}; do
        cp ${f} .
    done
}

do_populate_fastbootpkg_components[vardeps] += "FASTBOOTPKG_COMPONENTS"
do_populate_fastbootpkg_components[cleandirs] = "${FASTBOOTPKG_COMPONENTS_DESTDIR}/${PN}"
do_populate_fastbootpkg_components[dirs] = "${FASTBOOTPKG_COMPONENTS_DESTDIR}/${PN}"
do_clean[cleandirs] += "${FASTBOOTPKG_COMPONENTS_DESTDIR}/${PN}"

FASTBOOTPKG_COMPONENTS[doc] = "List of every artifacts to be placed in the fastboot staging dir"
FASTBOOTPKG_COMPONENTS ?= ""
