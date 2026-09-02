# Can override from machine conf file to package the most appropriate image
IMAGE_FSTYPE_FASTBOOTPKG ?= "ext4"

addtask assemble_fastbootpkg after do_image_complete before do_build
do_assemble_fastbootpkg[doc] = "Scan the FASTBOOTPKG_INSTALL variable and add every artifacts needed to create a selfcontained package to provision the target."
do_assemble_fastbootpkg() {
    for c in ${FASTBOOTPKG_INSTALL}; do
        cp -r ${FASTBOOTPKG_COMPONENTS_DESTDIR}/${c}/* .
    done
    # Copy the image into the fastboot package
    cp ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.${IMAGE_FSTYPE_FASTBOOTPKG} .
    # Create the package
    tar zcvf ${DEPLOY_DIR_IMAGE}/fastboot-pkg/fastboot-pkg.tgz ../${MACHINE}
}

do_assemble_fastbootpkg[dirs] = "${DEPLOY_DIR_IMAGE}/fastboot-pkg/${MACHINE}"
do_assemble_fastbootpkg[cleandirs] = "${DEPLOY_DIR_IMAGE}/fastboot-pkg"
# make sure the fastboot package directory is cleaned up
do_clean[cleandirs] += "${DEPLOY_DIR_IMAGE}/fastboot-pkg"

do_assemble_fastbootpkg[vardeps] += "FASTBOOTPKG_INSTALL"
do_assemble_fastbootpkg[depends] += "${@' '.join([pkg + ':do_populate_fastbootpkg_components' for pkg in (d.getVar('FASTBOOTPKG_INSTALL') or '').split()])}"
