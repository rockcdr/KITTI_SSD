cd /home/perception/KITTI_SSD/
./build/tools/caffe train \
--solver="/home/perception/KITTI_SSD//models/VGGNet/KITTI/SSD_600x150/solver.prototxt" \
--snapshot="/home/perception/KITTI_SSD//models/VGGNet/KITTI/SSD_600x150/VGG_KITTI_SSD_600x150_iter_56231.solverstate" \
--gpu 0,1,2,3 2>&1 | tee /home/perception/KITTI_SSD//jobs/VGGNet/KITTI/SSD_600x150/VGG_KITTI_SSD_600x150.log
