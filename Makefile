PREFIX ?= /usr
export PREFIX := ${PREFIX}

TARGETS ?= catclock \
		   sudoku \
		   juggle \
		   festoon

define create_phony_target
.PHONY: ${1}
${1}:
	for target in ${TARGETS}; \
		do \
		make -C $$$${target} ${1}; \
	done
endef

$(eval $(call create_phony_target,all))
$(eval $(call create_phony_target,clean))
$(eval $(call create_phony_target,install))
$(eval $(call create_phony_target,nuke))