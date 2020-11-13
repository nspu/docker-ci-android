FROM jangrewe/gitlab-ci-android

RUN apt-get --quiet update --yes
RUN apt-get --quiet install
RUN apt --quiet install --yes python
RUN apt --quiet install --yes python-setuptools
RUN apt --quiet install --yes git
RUN apt --quiet install --yes ca-certificates
RUN apt --quiet install --yes python-dateutil
RUN apt --quiet install --yes ubuntu-dev-tools
RUN apt --quiet install --yes ruby-dev
RUN gem install fastlane -NV

RUN git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd
RUN ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

WORKDIR /root

ADD ./files/s3cfg /root/.s3cfg
ADD ./files/main.sh /root/main.sh

# Main entrypoint script
RUN chmod 777 /root/main.sh

# Folders for s3cmd optionations
RUN mkdir /root/src
RUN mkdir /root/dest

WORKDIR /
CMD ["/root/main.sh"]
