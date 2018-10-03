# 3d_deep_rl

./run_nvidia_docker.sh DOCKER_IMAGE_NAME GPU_LIST

GPU0とGPU1を使うとき:GPU_LIST=0 1

run_nvidia_docker.shはnvidia-docker用(nvidia-docker2には非対応)

run_nvidia_docker.sh実行時にマウントするボリュームを指定する場合，host側のみ~を使用可能
