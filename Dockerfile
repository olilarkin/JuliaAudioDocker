FROM "jupyter/scipy-notebook"

USER root

ENV JULIA_VERSION=1.6.0

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz

RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

USER $NB_UID

# Add packages and precompile
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("Plots"); using Plots' && \
    julia -e 'import Pkg; Pkg.add("Interact"); using Interact' && \
    julia -e 'import Pkg; Pkg.add("IJulia"); using IJulia' && \
    julia -e 'import Pkg; Pkg.add("WebIO"); using WebIO' && \
    julia -e 'import Pkg; Pkg.add("FFTW"); using FFTW' && \
    julia -e 'import Pkg; Pkg.add("DSP"); using DSP' && \
    julia -e 'import Pkg; Pkg.add("WAV"); using WAV' && \
    julia -e 'import Pkg; Pkg.add("PyPlot"); using PyPlot' && \
    julia -e 'import Pkg; Pkg.add("Colors"); using Colors' && \
    julia -e 'import Pkg; Pkg.add("Images"); using Images' && \
    julia -e 'import Pkg; Pkg.add("SpecialFunctions"); using SpecialFunctions' && \
    julia -e 'using WebIO; WebIO.install_jupyter_nbextension()' && \
    fix-permissions /home/$NB_USER
