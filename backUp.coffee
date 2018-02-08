fsExtra = require 'fs-extra'
path = require 'path'
Promise = require 'bluebird'
_ = require 'lodash'
util = require 'util'
exec = util.promisify require('child_process').exec
tar = require 'tar'
fs = require 'fs'
HOME = '/root/'
HOST = '192.168.56.72'
backupList = require('./backup_list') HOME, HOST
fsExtra = require 'fs-extra'


module.exports =
  create_backup:()->
    await fsExtra.remove HOST
    await Promise.map backupList,(e) ->
      path = HOST + '/' + e.name
      fsExtra.mkdirs HOST + '/'+ e.name 
    
  countFolder: ()->
    countFolder  = "find  #{HOST} -type d | wc -l"
    try
      { stdout, stderr } = await exec  countFolder
      stdout
    catch e
      console.log "error--: ", e.stderr
  countFileAfterBackup:()->
    v = []
    count = 0
    await Promise.map backupList,(e) ->
      path = e.dest + '/' + e.name
      try
        command =  "find  #{path} -type f | wc -l    "
        { stdout, stderr } = await exec  command
        v.push stdout
      catch e
        console.log "error: ", e.stderr
    _.each v , (value,k)->
      num = parseInt value
      count = count + num
    count
  ssh_countfile:()->
    v = []
    count = 0
    await Promise.map backupList, (element) ->
      try
        command =  "ssh root@#{HOST} find #{element.src} -type f | wc -l    "
        { stdout, stderr } = await exec  command
        v.push stdout
      catch e
        console.log "error: ", e.stderr
    _.each v , (value,k)->

      num = parseInt value
      count = count + num
    count

  backup: () ->
    Promise.map backupList, (element) ->
      path = element.dest + '/' + element.name
      command = "scp -r -oStrictHostKeyChecking=no root@#{HOST}:#{element.src}  #{path}"
      try
        { stdout, stderr } = await exec  command
        stdout
      catch e
        console.log "error1: ", e.stderr


