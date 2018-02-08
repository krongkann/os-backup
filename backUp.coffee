fsExtra = require 'fs-extra'
path = require 'path'
Promise = require 'bluebird'
_ = require 'lodash'
util = require 'util'
exec = util.promisify require('child_process').exec
tar = require 'tar'
fs = require 'fs'

module.exports =
  backup: (backupList, host) ->
    Promise.map backupList, (element) ->
      # fsExtra.copy element.src, path.join __dirname, element.dest
      command = "scp -r -oStrictHostKeyChecking=no root@#{host}:#{element.src} #{element.dest}"
      try
        { stdout, stderr } = await exec command
      catch e
      stderr == ''

