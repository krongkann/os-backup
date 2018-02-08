path = require 'path'
module.exports = (home, host) ->
  [
      name: '.bashrc'
      src: path.join home, '.bashrc'
      dest: "#{host}/.bashrc"
    ,
      name: '.docker'
      src: path.join home, '.docker'
      dest: "#{host}/.docker"
    ,
      name: 'docker'
      src: '/etc/docker'
      dest: "#{host}/docker"
    ,
      name: 'hosts'
      src: '/etc/hosts'
      dest: "#{host}/hosts"
    ,
      name: 'openvpn'
      src: '/etc/openvpn'
      dest: "#{host}/openvpn"
  ]