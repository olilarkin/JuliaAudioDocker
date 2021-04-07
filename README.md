# JuliaAudioDocker
Docker image for audio DSP visualization with Julia in a Jupyter Notebook

## Usage

* Install docker desktop
* Navigate to the folder where your julia ipynb's are and run the following command

```docker run --rm -p 8888:8888 -v "$PWD":/home/jovyan/work olilarkin/julia-audio:latest```

or in windows powershell

```docker run --rm -p 8888:8888 -v ${PWD}:/home/jovyan/work olilarkin/julia-audio:latest```

