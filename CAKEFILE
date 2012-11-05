{print} = require 'util'
{spawn} = require 'child_process'

task 'build', 'compile', ->
  coffee = spawn 'coffee', ['-c', '-b', '-o', './lib', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()