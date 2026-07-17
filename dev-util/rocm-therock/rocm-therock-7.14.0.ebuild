# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
ROCM_VERSION=${PV}

inherit cmake python-single-r1 rocm

DESCRIPTION="Unified ROCm SDK built with TheRock"
HOMEPAGE="https://github.com/ROCm/TheRock"

THEROCK_COMMIT="418cd5f63abb7a604bad5874cd7b2e29334e640f"
LLVM_COMMIT="46fcb339fb61119b337f973c7ca9e710a319fdd0"
ROCM_LIBRARIES_COMMIT="cd9574023093742434e8c992d13b89ab9a6c1cf8"
ROCM_SYSTEMS_COMMIT="2b22ab0195cc1461cd9abf3b969e9dd7c10af350"
THEROCK_DEPS_URI="https://rocm-third-party-deps.s3.us-east-2.amazonaws.com"
SRC_URI="
	https://github.com/ROCm/TheRock/archive/${THEROCK_COMMIT}.tar.gz
		-> ${P}.tar.gz
	https://github.com/ROCm/half/archive/207ee58595a64b5c4a70df221f1e6e704b807811.tar.gz
		-> ${P}-half.tar.gz
	https://github.com/ROCm/rocm-cmake/archive/10155d7272ea1bf79f6b5a9dbc339657af1aa372.tar.gz
		-> ${P}-rocm-cmake.tar.gz
	https://github.com/ROCm/rocm-systems/archive/${ROCM_SYSTEMS_COMMIT}.tar.gz
		-> ${P}-rocm-systems.tar.gz
	blas? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	composable-kernel? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	fft? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	hipblaslt-provider? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	hipdnn? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	hipdnn-samples? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	hipkernel-provider? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	hiptensor? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	miopen? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	miopen-provider? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	prim? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	rand? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	rccl? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	rocalution? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	rocwmma? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	solver? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	sparse? ( https://github.com/ROCm/rocm-libraries/archive/${ROCM_LIBRARIES_COMMIT}.tar.gz -> ${P}-rocm-libraries.tar.gz )
	compiler? (
		https://github.com/ROCm/llvm-project/archive/${LLVM_COMMIT}.tar.gz
			-> ${P}-llvm-project.tar.gz
		https://github.com/ROCm/SPIRV-LLVM-Translator/archive/fb08e83ae872775acfeaee53fda3ccf99a04ba53.tar.gz
			-> ${P}-spirv-llvm-translator.tar.gz
	)
	hipify? (
		https://github.com/ROCm/HIPIFY/archive/6acec7751d2b2bfe162dba9efdcf7c16efb27bd8.tar.gz
			-> ${P}-hipify.tar.gz
	)
	libhipcxx? (
		https://github.com/ROCm/libhipcxx/archive/fa4ccc6beb77bfaa59a6fbeeebc94a4f18678945.tar.gz
			-> ${P}-libhipcxx.tar.gz
	)
	rocgdb? (
		https://github.com/ROCm/rocgdb/archive/36d878807f07f08e94f87b7d701de53ae2c4f207.tar.gz
			-> ${P}-rocgdb.tar.gz
	)
	miopen? (
		https://github.com/ROCm/MIFin/archive/06650bddfe40c47294b0414e4262691333b788dd.tar.gz
			-> ${P}-mifin.tar.gz
	)
	${THEROCK_DEPS_URI}/Catch2-3.8.1.tar.gz
	${THEROCK_DEPS_URI}/FunctionalPlus-0.2.25.tar.gz
	${THEROCK_DEPS_URI}/OpenBLAS-18638c7.tar.gz
	${THEROCK_DEPS_URI}/SuiteSparse-7.8.3.tar.gz
	${THEROCK_DEPS_URI}/boost_1_87_0-1.tar.bz2
	${THEROCK_DEPS_URI}/eigen-3.4.0.tar.bz2
	${THEROCK_DEPS_URI}/elfio-3.12.tar.gz
	${THEROCK_DEPS_URI}/fftw-3.3.10.tar.gz
	${THEROCK_DEPS_URI}/flatbuffers-25.9.23.tar.gz
	${THEROCK_DEPS_URI}/fmt-11.1.3.zip
	${THEROCK_DEPS_URI}/frugally-deep-0.15.31.tar.gz
	${THEROCK_DEPS_URI}/googletest-1.17.0.tar.gz
	${THEROCK_DEPS_URI}/grpc-v1.78.1.tar.gz
	${THEROCK_DEPS_URI}/json-3.12.0.tar.gz
	${THEROCK_DEPS_URI}/libdivide-5.2.0.tar.gz
	${THEROCK_DEPS_URI}/msgpack-cxx-7.0.0.tar.gz
	${THEROCK_DEPS_URI}/nanobind-2.12.0.tar.gz
	${THEROCK_DEPS_URI}/openmpi-5.0.9.tar.bz2
	${THEROCK_DEPS_URI}/robin-map-1.4.1.tar.gz
	${THEROCK_DEPS_URI}/simde-0.8.2.tar.gz
	${THEROCK_DEPS_URI}/spdlog-1.15.3.tar.gz
	${THEROCK_DEPS_URI}/yaml-cpp-0.8.0.tar.gz
"

S="${WORKDIR}/TheRock-${THEROCK_COMMIT}"

LICENSE="Apache-2.0 BSD Boost-1.0 MIT UoI-NCSA
	rocgdb? ( GPL-2+ LGPL-2+ )"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"

IUSE="
	+compiler +opencl +runtime
	amdsmi blas composable-kernel dbgapi fft hip hipblaslt-provider hipdnn
	hipdnn-samples hipfile hipify hipkernel-provider hiptensor libhipcxx
	miopen miopen-provider mpi prim rand rccl rdc rocalution rocdecode rocgdb
	rocjpeg rocjitsu rocprofiler rocprofiler-compute rocprofiler-systems
	rocr-debug-agent rocshmem rocwmma solver sparse test
"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	rocprofiler-compute? ( rocprofiler )
	rocprofiler-systems? ( rocprofiler )
	hipblaslt-provider? ( hipdnn blas )
	hipkernel-provider? ( hipdnn )
	miopen-provider? ( hipdnn miopen )
	hipdnn-samples? ( hipdnn miopen-provider )
"

COMMON_DEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	app-arch/zstd
	dev-cpp/glog
	dev-libs/elfutils
	dev-libs/libedit
	dev-libs/libffi
	dev-libs/libfmt
	dev-libs/libxml2
	sys-libs/ncurses:=
	sys-libs/zlib
	sys-process/numactl
	x11-libs/libdrm[video_cards_amdgpu]
	amdsmi? (
		dev-libs/libnl:3
		net-libs/libmnl
	)
	mpi? ( virtual/mpi )
	miopen? (
		dev-cpp/eigen
		dev-cpp/nlohmann_json
		dev-libs/flatbuffers
		dev-libs/msgpack
	)
	rocdecode? ( media-libs/mesa[video_cards_radeonsi] )
	rocjpeg? ( media-libs/mesa[video_cards_radeonsi] )
"

DEPEND="${COMMON_DEPEND}
	sys-kernel/linux-headers
"

RDEPEND="${COMMON_DEPEND}
	!dev-build/rocm-cmake
	!dev-libs/rocm-core
	!dev-util/rocm-smi
	compiler? (
		!dev-libs/rocm-comgr
		!dev-libs/rocm-device-libs
		!dev-util/hipcc
	)
	runtime? (
		!dev-libs/rocr-runtime
		!dev-libs/roct-thunk-interface
		!dev-util/rocminfo
	)
	opencl? (
		!dev-libs/rocm-opencl-runtime
		media-libs/mesa[-opencl]
	)
	hip? ( !dev-util/hip )
	dbgapi? ( !dev-libs/rocdbgapi )
	blas? (
		!dev-util/Tensile
		!sci-libs/hipBLAS
		!sci-libs/hipBLAS-common
		!sci-libs/hipBLASLt
		!sci-libs/rocBLAS
	)
"

BDEPEND="
	${PYTHON_DEPS}
	app-editors/vim-core
	dev-build/automake
	dev-build/cmake
	dev-build/libtool
	dev-build/ninja
	dev-lang/perl
	$(python_gen_cond_dep '
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/mako[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pyelftools[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
	')
	dev-vcs/git
	sys-apps/texinfo
	sys-devel/bison
	sys-devel/flex
	sys-devel/gcc[fortran]
	virtual/pkgconfig
	rocgdb? ( dev-util/patchelf )
"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/${P}-system-rocprofiler-register-deps.patch"
)

src_unpack() {
	default

	# Commit archives avoid git-r3's mandatory full-history mirrors for
	# submodules.  Keep the layout expected by the TheRock superproject.
	mkdir -p "${S}"/{base,compiler,debug-tools/rocgdb,math-libs} || die
	rmdir "${S}/base/half" "${S}/base/rocm-cmake" \
		"${S}/rocm-systems" 2>/dev/null || die
	mv "${WORKDIR}/half-207ee58595a64b5c4a70df221f1e6e704b807811" \
		"${S}/base/half" || die
	mv "${WORKDIR}/rocm-cmake-10155d7272ea1bf79f6b5a9dbc339657af1aa372" \
		"${S}/base/rocm-cmake" || die
	mv "${WORKDIR}/rocm-systems-${ROCM_SYSTEMS_COMMIT}" \
		"${S}/rocm-systems" || die
	if use_any blas composable-kernel fft hipblaslt-provider hipdnn \
		hipdnn-samples hipkernel-provider hiptensor miopen miopen-provider prim \
		rand rccl rocalution rocwmma solver sparse; then
		rmdir "${S}/rocm-libraries" 2>/dev/null || die
		mv "${WORKDIR}/rocm-libraries-${ROCM_LIBRARIES_COMMIT}" \
			"${S}/rocm-libraries" || die
	fi

	if use compiler; then
		rmdir "${S}/compiler/amd-llvm" \
			"${S}/compiler/spirv-llvm-translator" 2>/dev/null || die
		mv "${WORKDIR}/llvm-project-${LLVM_COMMIT}" \
			"${S}/compiler/amd-llvm" || die
		mv "${WORKDIR}/SPIRV-LLVM-Translator-fb08e83ae872775acfeaee53fda3ccf99a04ba53" \
			"${S}/compiler/spirv-llvm-translator" || die
	fi
	if use hipify; then
		rmdir "${S}/compiler/hipify" 2>/dev/null || die
		mv "${WORKDIR}/HIPIFY-6acec7751d2b2bfe162dba9efdcf7c16efb27bd8" \
			"${S}/compiler/hipify" || die
	fi
	if use libhipcxx; then
		rmdir "${S}/math-libs/libhipcxx" 2>/dev/null || die
		mv "${WORKDIR}/libhipcxx-fa4ccc6beb77bfaa59a6fbeeebc94a4f18678945" \
			"${S}/math-libs/libhipcxx" || die
	fi
	if use rocgdb; then
		rmdir "${S}/debug-tools/rocgdb/source" 2>/dev/null || die
		mv "${WORKDIR}/rocgdb-36d878807f07f08e94f87b7d701de53ae2c4f207" \
			"${S}/debug-tools/rocgdb/source" || die
	fi
	if use miopen; then
		rmdir "${S}/rocm-libraries/projects/miopen/fin" 2>/dev/null || die
		mv "${WORKDIR}/MIFin-06650bddfe40c47294b0414e4262691333b788dd" \
			"${S}/rocm-libraries/projects/miopen/fin" || die
	fi
}

src_prepare() {
	# These are part of the tagged TheRock source state, but are intentionally
	# carried outside the llvm-project submodule.
	local patch
	pushd compiler/amd-llvm >/dev/null || die
	for patch in "${S}"/patches/amd-mainline/llvm-project/*.patch; do
		eapply "${patch}"
	done
	popd >/dev/null || die

	# ExternalProject downloads happen during src_compile, where Portage blocks
	# the network.  All hash-pinned archives are fetched by SRC_URI instead.
	grep -RIlZ 'https://rocm-third-party-deps.s3.us-east-2.amazonaws.com/' \
		--include='CMakeLists.txt' third-party | xargs -0 sed -i \
		-e "s|https://rocm-third-party-deps.s3.us-east-2.amazonaws.com/|file://${DISTDIR}/|g" || die

	cmake_src_prepare
}

src_configure() {
	local amdgpu_targets
	amdgpu_targets=$(get_amdgpu_flags)
	amdgpu_targets=${amdgpu_targets%;}

	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
		-DTHEROCK_BUILD_TESTING=$(usex test ON OFF)
		-DTHEROCK_BUNDLE_SYSDEPS=OFF
		-DTHEROCK_ENABLE_ALL=OFF
		-DTHEROCK_ENABLE_BASE=ON
		-DTHEROCK_PACKAGE_VERSION=${PV}
		-DTHEROCK_AMDGPU_TARGETS="${amdgpu_targets}"
		-DTHEROCK_DIST_AMDGPU_TARGETS="${amdgpu_targets}"
		-DTHEROCK_TEST_AMDGPU_TARGETS="${amdgpu_targets}"
		-DTHEROCK_FLAG_KPACK_SPLIT_ARTIFACTS=ON
		-DTHEROCK_FLAG_STAMP_LIBRARY_GIT_VERSIONS=OFF

		-DTHEROCK_ENABLE_COMPILER=$(usex compiler ON OFF)
		-DTHEROCK_ENABLE_HIPIFY=$(usex hipify ON OFF)
		-DTHEROCK_ENABLE_CORE_AMDSMI=$(usex amdsmi ON OFF)
		-DTHEROCK_ENABLE_CORE_RUNTIME=$(usex runtime ON OFF)
		-DTHEROCK_ENABLE_HIP_RUNTIME=$(usex hip ON OFF)
		-DTHEROCK_ENABLE_OCL_RUNTIME=$(usex opencl ON OFF)
		-DTHEROCK_ENABLE_ROCPROFV3=$(usex rocprofiler ON OFF)
		-DTHEROCK_ENABLE_ROCPROFILER_COMPUTE=$(usex rocprofiler-compute ON OFF)
		-DTHEROCK_ENABLE_ROCPROFSYS=$(usex rocprofiler-systems ON OFF)
		-DTHEROCK_ENABLE_ROCJITSU=$(usex rocjitsu ON OFF)
		-DTHEROCK_ENABLE_BLAS=$(usex blas ON OFF)
		-DTHEROCK_ENABLE_RAND=$(usex rand ON OFF)
		-DTHEROCK_ENABLE_FFT=$(usex fft ON OFF)
		-DTHEROCK_ENABLE_PRIM=$(usex prim ON OFF)
		-DTHEROCK_ENABLE_SPARSE=$(usex sparse ON OFF)
		-DTHEROCK_ENABLE_SOLVER=$(usex solver ON OFF)
		-DTHEROCK_ENABLE_ROCALUTION=$(usex rocalution ON OFF)
		-DTHEROCK_ENABLE_ROCWMMA=$(usex rocwmma ON OFF)
		-DTHEROCK_ENABLE_COMPOSABLE_KERNEL=$(usex composable-kernel ON OFF)
		-DTHEROCK_ENABLE_HIPTENSOR=$(usex hiptensor ON OFF)
		-DTHEROCK_ENABLE_LIBHIPCXX=$(usex libhipcxx ON OFF)
		-DTHEROCK_ENABLE_MIOPEN=$(usex miopen ON OFF)
		-DTHEROCK_ENABLE_HIPDNN=$(usex hipdnn ON OFF)
		-DTHEROCK_ENABLE_MIOPENPROVIDER=$(usex miopen-provider ON OFF)
		-DTHEROCK_ENABLE_HIPBLASLTPROVIDER=$(usex hipblaslt-provider ON OFF)
		-DTHEROCK_ENABLE_HIPKERNELPROVIDER=$(usex hipkernel-provider ON OFF)
		-DTHEROCK_ENABLE_HIPDNN_SAMPLES=$(usex hipdnn-samples ON OFF)
		-DTHEROCK_ENABLE_RCCL=$(usex rccl ON OFF)
		-DTHEROCK_ENABLE_ROCSHMEM=$(usex rocshmem ON OFF)
		-DTHEROCK_ENABLE_HIPFILE=$(usex hipfile ON OFF)
		-DTHEROCK_ENABLE_AMD_DBGAPI=$(usex dbgapi ON OFF)
		-DTHEROCK_ENABLE_ROCR_DEBUG_AGENT=$(usex rocr-debug-agent ON OFF)
		-DTHEROCK_ENABLE_ROCGDB=$(usex rocgdb ON OFF)
		-DTHEROCK_ENABLE_RDC=$(usex rdc ON OFF)
		-DTHEROCK_ENABLE_ROCDECODE=$(usex rocdecode ON OFF)
		-DTHEROCK_ENABLE_ROCJPEG=$(usex rocjpeg ON OFF)
		-DTHEROCK_ENABLE_MPI=$(usex mpi ON OFF)
	)

	if use test; then
		mycmakeargs+=(
			-DTHEROCK_ENABLE_CORE_HIPTESTS=$(usex hip ON OFF)
			-DTHEROCK_ENABLE_ROCR_DEBUG_AGENT_TESTS=$(usex rocr-debug-agent ON OFF)
		)
	else
		mycmakeargs+=(
			-DTHEROCK_ENABLE_CORE_HIPTESTS=OFF
			-DTHEROCK_ENABLE_CORE_RUNTIME_TESTS=OFF
			-DTHEROCK_ENABLE_HIPDNN_INTEGRATION_TESTS=OFF
			-DTHEROCK_ENABLE_ROCR_DEBUG_AGENT_TESTS=OFF
		)
	fi

	cmake_src_configure
}

src_test() {
	check_amdgpu
	cmake_src_test
}
