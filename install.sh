# Connect to google cloud storage
apt install -y unzip
curl https://rclone.org/install.sh | bash


# check if torch supports GPU; this must output "True". You need CUDA 11. installed for this. You might be able to use
# a different version, but this is what I tested.
python -c "import torch; print(torch.cuda.is_available())"

# clone web ui and go into its directory
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

# clone repositories for Stable Diffusion and (optionally) CodeFormer
mkdir repositories
git clone https://github.com/CompVis/stable-diffusion.git repositories/stable-diffusion
git clone https://github.com/CompVis/taming-transformers.git repositories/taming-transformers
git clone https://github.com/sczhou/CodeFormer.git repositories/CodeFormer

# install requirements of Stable Diffusion
pip install transformers==4.19.2 diffusers invisible-watermark

# install k-diffusion
pip install git+https://github.com/crowsonkb/k-diffusion.git

# (optional) install GFPGAN (face resoration)
pip install git+https://github.com/TencentARC/GFPGAN.git

# (optional) install requirements for CodeFormer (face resoration)
pip install -r repositories/CodeFormer/requirements.txt

# install requirements of web ui
pip install -r requirements.txt

# update numpy to latest version
pip install -U numpy
pip install markupsafe==2.0.1

apt install ffmpeg libsm6 libxext6  -y

# (outside of command line) put stable diffusion model into web ui directory
# the command below must output something like: 1 File(s) 4,265,380,512 bytes
curl https://www.googleapis.com/storage/v1/b/aai-blog-files/o/sd-v1-4.ckpt?alt=media > model.ckpt

# (outside of command line) put the GFPGAN model into web ui directory
# the command below must output something like: 1 File(s) 348,632,874 bytes
wget https://github.com/TencentARC/GFPGAN/releases/download/v1.3.0/GFPGANv1.3.pth

wget https://raw.githubusercontent.com/andymelichar/stable-diffusion-ui-installer/main/scheduler.py

python scheduler.py &

python webui.py --share &
