should = require 'should'
swizzle = require '../'

Error.stackTraceLimit = Infinity

swizMyself = -> swizzle arguments

it 'should swizzle single values', ->
	(swizMyself  1, 2, 3, 4).should.deepEqual [1, 2, 3, 4]
	(swizMyself  1, 2, 3, 4).should.not.deepEqual [1, 2, 4]
	swizMyself().should.deepEqual []

it 'should swizzle a single array', ->
	(swizMyself [1, 2, 3, 4]).should.deepEqual [1, 2, 3, 4]

it 'should swizzle interleaved values/arrays', ->
	(swizMyself 1, 2, [3, 4]).should.deepEqual [1, 2, 3, 4]
	(swizMyself [1, 2], [3, 4]).should.deepEqual [1, 2, 3, 4]
	(swizMyself [1, 2, 3], 4).should.deepEqual [1, 2, 3, 4]
	(swizMyself [1], [2], [3], [4]).should.deepEqual [1, 2, 3, 4]

it 'should swizzle pseudo-arrays', ->
	(swizMyself 1, 2, {length: 2, 0: 3, 1: 4}).should.deepEqual [1, 2, 3, 4]
	(swizMyself {length: 1, 0: 1}, 2, 3, {length: 1, 0: 4}).should.deepEqual [1, 2, 3, 4]
