# ARCHIVE OF AN UNFINISHED PROJECT

> I spent a day playing with FreeBSD image building because I was appaled by
> the fact that the only FreeBSD templates readily available on Yandex Cloud
> are provided by a third party for an extra price of 7200 RUB/mo (close to
> $100/mo), and that's on top of any compute costs required to run them.
>
> The project was moderately fun but not very educational, all the tools used
> were not new to me. I also have no real need for FreeBSD instances in Yandex
> Cloud, so it's not rational for me to keep pouring effort into this.
>
> Current state of the project is far from ready:
>   - Images get built fine, but the build process is incredibly slow because
>     of single threaded xz unarchiving
>   - Serial console is not properly enabled at startup
>   - Cloud-init is installed but fails to pick up Yandex Cloud datasource,
>     further troubleshooting was not attempted because of the previous two
>     points
>
> There are many similar projects by more driven and competent authors, you
> should probably use of of those:
>   - [virt-lightning/freebsd-cloud-images](https://github.com/virt-lightning/freebsd-cloud-images)
>     (published at [bsd-cloud-image.org](https://bsd-cloud-image.org/))
>   - [thome/freebsd-cloud-image](https://gitlab.inria.fr/thome/freebsd-cloud-image)
>
> In general, building VM images from scratch seems to be a better path
> because all speed improvements from a shorter build process are lost on xz
> unarchiving.

---

# FreeBSD images for Yandex Cloud

This project contains build scripts and surrounding configuration for
uploading FreeBSD images to Yandex Compute Cloud.

## License and copyright

### Contents of this repository

Copyright 2023 Vitaly Potyarkin.
Distributed under [BSD 2-Clause License](LICENSE)

### Upstream FreeBSD project

Copyright 1992-2023 The FreeBSD Project.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

     1. Redistributions of source code must retain the above copyright notice,
        this list of conditions and the following disclaimer.

     2. Redistributions in binary form must reproduce the above copyright notice,
        this list of conditions and the following disclaimer in the documentation
        and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS "AS IS" AND ANY
    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
    ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

    The views and conclusions contained in the software and documentation are
    those of the authors and should not be interpreted as representing official
    policies, either expressed or implied, of the FreeBSD Project.
