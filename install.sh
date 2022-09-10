# install Python 3.8.5 and pip 20.3
apt update
apt install -y python3.8 python3-pip

# install torch with CUDA support. See https://pytorch.org/get-started/locally/ for more instructions if this fails.
pip3 install torch --extra-index-url https://download.pytorch.org/whl/cu113

# check if torch supports GPU; this must output "True". You need CUDA 11. installed for this. You might be able to use
# a different version, but this is what I tested.
python3 -c "import torch; print(torch.cuda.is_available())"

# clone web ui and go into its directory
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui

# clone repositories for Stable Diffusion and (optionally) CodeFormer
mkdir repositories
git clone https://github.com/CompVis/stable-diffusion.git repositories/stable-diffusion
git clone https://github.com/CompVis/taming-transformers.git repositories/taming-transformers
git clone https://github.com/sczhou/CodeFormer.git repositories/CodeFormer

# install requirements of Stable Diffusion
pip3 install transformers==4.19.2 diffusers invisible-watermark --prefer-binary

# install k-diffusion
pip3 install git+https://github.com/crowsonkb/k-diffusion.git --prefer-binary

# (optional) install GFPGAN (face resoration)
pip3 install git+https://github.com/TencentARC/GFPGAN.git --prefer-binary

# (optional) install requirements for CodeFormer (face resoration)
pip3 install -r repositories/CodeFormer/requirements.txt --prefer-binary

# install requirements of web ui
pip3 install -r requirements.txt  --prefer-binary

# update numpy to latest version
pip3 install -U numpy  --prefer-binary

# (outside of command line) put stable diffusion model into web ui directory
# the command below must output something like: 1 File(s) 4,265,380,512 bytes
dir model.ckpt

# (outside of command line) put the GFPGAN model into web ui directory
# the command below must output something like: 1 File(s) 348,632,874 bytes
dir GFPGANv1.3.pth