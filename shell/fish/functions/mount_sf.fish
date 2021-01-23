# mount shared folders in VM guest
function mount_sf --description "mount shared folders in VM guest"
    mount -t code test /home/shank/sf_code
    mount -t MEGA test /home/shank/sf_MEGA
    mount -t Downloads test /home/shank/sf_Downloads
end
