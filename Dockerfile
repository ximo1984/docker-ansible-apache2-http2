FROM ubuntu:16.04

# Bootstrap Ansible via pip
RUN apt-get update && apt-get install -y wget gcc make python python-dev python-setuptools python-pip python-apt libffi-dev libssl-dev libyaml-dev
RUN pip install -U pip
RUN pip install -U ansible

# Prepare Ansible environment
RUN mkdir /ansible
COPY . /ansible
ENV ANSIBLE_ROLES_PATH /ansible/roles

# Launch Ansible playbook from inside container
RUN cd /ansible && ansible-playbook -c local -v provision.yml

# Cleanup
RUN rm -rf /ansible
RUN for dep in $(pip show ansible | grep Requires | sed 's/Requires: //g; s/,//g'); do pip uninstall -y $dep; done
RUN apt-get purge -y python-dev python-pip  && apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp* /usr/share/doc/* /root/.cache/pip

ENTRYPOINT ["docker-entrypoint.sh"]