{  create_backup, backup, countFolder, ssh_countfile, countFileAfterBackup } = require './backUp'
{ expect } = require 'chai'
_ = require 'lodash'
path = require 'path'
Promise = require 'bluebird'
util = require 'util'
exec = util.promisify require('child_process').exec
backupList = require('./backup_list') 
HOST = '192.168.56.72'

describe "BACKUP AND RESTORE File", ->
  before ->
    console.log 'Hello World!'
 
  it 'should create folder backup', ->
    await create_backup()
    all_file = await countFolder()
    all_list = backupList("","").length + 1
    expect(all_file).to.eq "#{all_list}\n"

  it 'should Backup', ->
    this.timeout 0
    await  backup()
    # countFolder = await countFolder()
    ssh_countfile = await ssh_countfile()
    # create_backup = await create_backup()
    # # console.log "countFolder===", countFolder
    console.log "ssh_countfile", ssh_countfile
    # # console.log "create_backup", create_backup
    countFileAfterBackup =  await countFileAfterBackup()

    expect(ssh_countfile).to.eq countFileAfterBackup

    # await tarCreate HOST
    # tarExist = await fsExtra.pathExists path.join __dirname, "#{HOST}.tgz"
    # expect(tarExist).to.be.true

    # await fsExtra.remove "#{HOST}"
    # folderExist = await fsExtra.pathExists path.join __dirname, "#{HOST}"
    # expect(folderExist).to.be.false

