function prime-run -d "prime-run (for using cuda in pytorch)"
    __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia $argv
end
