#!/bin/bash
set -exuo pipefail

readonly version="$1"

readonly org='k3s-io'
readonly proj='klipper-lb'
readonly arch='loongarch64'
readonly goarch='loong64'
readonly proj_name="${proj}-${version}"

# 映射目录
readonly workspace="/workspace"
readonly dists="${workspace}/dists"
readonly patches="${workspace}/patches"

readonly build="/build"
readonly source_root="${build}/${proj_name}"
readonly build_root="${build}/${proj_name}"
readonly package_root="${dists}/${proj_name}"

mkdir -p "${build}"

fetch_source_code()
{
    rm -rf "${source_root}"
    git clone --branch "v${version}" --depth=1 "https://github.com/${org}/${proj}" "${source_root}"
}

build(){
    pushd "${build_root}"
        sed -i 's:alpine:lcr.loongnix.cn/library/alpine:g' Dockerfile
        cp ${workspace}/files/scripts/version ./scripts/
        make
    popd
}

package(){
    rm -rf "${package_root}"
    mkdir -p "${package_root}"
    pushd "${package_root}"
        docker save lcr.loongnix.cn/rancher/klipper-lb:v${version}-loong64 -o klipper-lb-v${version}.tar
    popd

}

main()
{
    fetch_source_code
    build
    package
}

main "$@"
