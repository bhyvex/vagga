setup() {
    cd /work/tests/gem_bundler
}

teardown() {
    cd /work/tests/gem_bundler
    if [ -f Gemfile.lock ]; then rm Gemfile.lock; fi
    if [ -d .bundle ]; then rm -r .bundle; fi
}

@test "gem/bundler: alpine pkg" {
    run vagga _run pkg-alpine rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 11.1.1" ]]
    link=$(readlink .vagga/pkg-alpine)
    [[ $link = ".roots/pkg-alpine.d41880cf/root" ]]
}

@test "gem/bundler: alpine pkg no update gem" {
    run vagga _run pkg-alpine-no-update-gem rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 11.1.1" ]]
    link=$(readlink .vagga/pkg-alpine-no-update-gem)
    [[ $link = ".roots/pkg-alpine-no-update-gem.ecca9ae2/root" ]]
}

@test "gem/bundler: ubuntu trusty pkg" {
    run vagga _run pkg-ubuntu-trusty rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 11.1.1" ]]
    link=$(readlink .vagga/pkg-ubuntu-trusty)
    [[ $link = ".roots/pkg-ubuntu-trusty.a7fda1d0/root" ]]
}

@test "gem/bundler: ubuntu trusty pkg no update gem" {
    run vagga _run pkg-ubuntu-trusty-no-update-gem rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 11.1.1" ]]
    link=$(readlink .vagga/pkg-ubuntu-trusty-no-update-gem)
    [[ $link = ".roots/pkg-ubuntu-trusty-no-update-gem.df99a46b/root" ]]
}

@test "gem/bundler: ubuntu precise pkg" {
    run vagga _run pkg-ubuntu-precise rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 10.5.0" ]]
    link=$(readlink .vagga/pkg-ubuntu-precise)
    [[ $link = ".roots/pkg-ubuntu-precise.6f53261c/root" ]]
}

@test "gem/bundler: ubuntu precise pkg no update gem" {
    run vagga _run pkg-ubuntu-precise-no-update-gem rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 10.5.0" ]]
    link=$(readlink .vagga/pkg-ubuntu-precise-no-update-gem)
    [[ $link = ".roots/pkg-ubuntu-precise-no-update-gem.193c4b9d/root" ]]
}

@test "gem/bundler: alpine GemBundle" {
    run vagga _run bundle-alpine rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 11.1.1" ]]
    [[ -d .vagga/bundle-alpine/usr/lib/ruby/gems/2.3.0/gems/cuba-3.5.0 ]]
    link=$(readlink .vagga/bundle-alpine)
    [[ $link = ".roots/bundle-alpine.f5a177ef/root" ]]
}

@test "gem/bundler: alpine GemBundle without dev" {
    run vagga _build bundle-alpine-no-dev
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ -d .vagga/bundle-alpine-no-dev/usr/lib/ruby/gems/2.3.0/gems/cuba-3.5.0 ]]
    [[ ! -d .vagga/bundle-alpine-no-dev/usr/lib/ruby/gems/2.3.0/gems/rake-11.1.1 ]]
    link=$(readlink .vagga/bundle-alpine-no-dev)
    [[ $link = ".roots/bundle-alpine-no-dev.f5a177ef/root" ]]
}

@test "gem/bundler: ubuntu GemBundle" {
    run vagga _run bundle-ubuntu rake --version
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ ${lines[${#lines[@]}-1]} = "rake, version 11.1.1" ]]
    [[ -d .vagga/bundle-ubuntu/usr/lib/ruby/gems/1.9.1/gems/cuba-3.5.0 ]]
    link=$(readlink .vagga/bundle-ubuntu)
    [[ $link = ".roots/bundle-ubuntu.b9dbe811/root" ]]
}

@test "gem/bundler: ubuntu GemBundle without dev" {
    run vagga _build bundle-ubuntu-no-dev
    printf "%s\n" "${lines[@]}"
    [[ $status = 0 ]]
    [[ -d .vagga/bundle-ubuntu-no-dev/usr/lib/ruby/gems/1.9.1/gems/cuba-3.5.0 ]]
    [[ ! -d .vagga/bundle-ubuntu-no-dev/usr/lib/ruby/gems/1.9.1/gems/rake-11.1.1 ]]
    link=$(readlink .vagga/bundle-ubuntu-no-dev)
    [[ $link = ".roots/bundle-ubuntu-no-dev.b9dbe811/root" ]]
}

@test "gem/bundler: GemBundle invalid trust_policy" {
    run vagga _build bundle-invalid-trust-policy
    printf "%s\n" "${lines[@]}"
    [[ $status = 121 ]]
    [[ $output = *"Value of 'GemBundle.trust_policy' must be 'LowSecurity', 'MediumSecurity' or 'HighSecurity', 'invalid' given"* ]]
}
