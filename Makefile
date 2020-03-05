CWD    = $(CURDIR)
MODULE = $(notdir $(CWD))

.PHONY: build
build: llvm/README.md
	rm -rf $@ ; mkdir $@
	cd $@ ; cmake ../llvm/llvm \
		-DCMAKE_INSTALL_PREFIX=$(CWD)/install -DCMAKE_BUILD_TYPE=Release \
		-DLLVM_ENABLE_PROJECTS=mlir -DLLVM_TARGETS_TO_BUILD="X86" \
		-DLLVM_ENABLE_ASSERTIONS=ON \
		-DCMAKE_C_COMPILER=clang-7 -DCMAKE_CXX_COMPILER=clang++-7 -DLLVM_ENABLE_LLD=ON
	cd $@ ; cmake --build . --target check-mlir

.PHONY: install
install: debian build
llvm/README.md:
	git clone --depth=1 https://github.com/llvm/llvm-project.git llvm

.PHONY: debian
debian:
	sudo apt update
	sudo apt install -u clang-7
