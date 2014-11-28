main = ($scope, $interval) ->
  canvas = document.getElementById("canvas")
  ctx = canvas.getContext("2d")
  grid = ->
    @cur = [[(Math.random!) for x from 0 til 32] for y from 0 til 32]
    @fur = [[0 for x from 0 til 32] for y from 0 til 32]
    @pat = [(if Math.random! > 0.8 => 1 else 0) for x from 0 til 512]
    @tic = [[1 for x from 0 til 32] for y from 0 til 32]
    #seed = parseInt( Math.random!* 50 ) + 2
    #for i from 0 til 512
    #  @pat[i] = if i % seed == 0 => 1 else 0
    @

  grid.prototype.iterate = ->
    for y from 0 til 32 => for x from 0 til 32 => @fur[y][x] = @cur[y][x]
    for y from 0 til 32
      for x from 0 til 32
        p = 1
        r = 0
        for dy from -1 til 2
          for dx from -1 til 2
            cx = x + dx
            cy = y + dy
            if cx < 0 => cx = 31
            if cx > 31 => cx = 0
            if cy < 0 => cy = 31
            if cy > 31 => cy = 0
            if @cur[cy][cx] >= 0.5 => r += p
            p *= 2
        tick = @tic[y][x]
        dv = 0.1 - (tick / 1000)
        dv >?= 0
        @tic[y][x] = @tic[y][x] + 1
        if @pat[r] => @fur[y][x] += dv
        else => @fur[y][x] -= dv
        #fur[y][x] <?= 1
        #fur[y][x] >?= 0
    for y from 0 til 32 => for x from 0 til 32 =>
      if @fur[y][x] >= 0.9 or @fur[y][x] <= 0.1 => @tic[y][x] = 1
      if @tic[y][x]>=100 and @fur[y][x] < 0.99 => @fur[y][x] = @fur[y][x] / 2
      @fur[y][x]>?=0
      @fur[y][x]<?=1
    tmp = @fur
    @fur = @cur
    @cur = tmp

  $('#canvas').on 'mousemove', (e) ->
    x = e.offsetX
    y = e.offsetY
    x = parseInt(x / 10)
    y = parseInt(y / 10)
    for dy from -1 to 1
      for dx from -1 to 1
        cy = y + dy
        cx = x + dx
        if cx < 0 => cx = 31
        if cx > 31 => cx = 0
        if cy < 0 => cy = 31
        if cy > 31 => cy = 0
        grid1.cur[cy][cx] = 1
        grid2.cur[cy][cx] = 1
        grid3.cur[cy][cx] = 1

  grid1 = new grid!
  grid2 = new grid!
  grid3 = new grid!


  maze = [0 for i from 0 til 512]
  list = [0 2 8 32 128 3 6 9 72 36 288 384 192 18 24 48 144 11 14 17 80 392 200 130 40 56 19 22 25 88 52 304 208 400 146 178 154 184 58]
  list.map -> maze[it] = 1
  grid1.pat = maze

  render = ->
    for y from 0 til 32
      for x from 0 til 32
        r = parseInt(grid1.cur[y][x] * 255.0)
        g = parseInt(grid2.cur[y][x] * 255.0)
        b = parseInt(grid3.cur[y][x] * 255.0)

        r = parseInt(grid1.cur[y][x] *  64.0 + grid2.cur[y][x] * 192.0)
        g = parseInt(grid1.cur[y][x] * 192.0 + grid2.cur[y][x] *  64.0)
        b = 0
        ctx.fillStyle = "rgba(#r,#g,#b,1)" #if cur[y][x] => '#000' else '#fff'
        ctx.fillRect x * 10, y * 10, 9, 9

  render!
  $interval -> 
    grid1.iterate!
    grid2.iterate!
    grid3.iterate!
    render!
  , 10


  /*line-pattern = ->
    pat := [0 for x from 0 til 512]
    pat[280] = 1
    pat[28] = 1
    pat[103] = 1
    pat[97] = 1
    pat[8] = 1
    pat[32] = 1
    pat[24] = 1
    pat[40] = 1
    pat[48] = 1
    pat[56] = 1
    pat[16] = 1
  #line-pattern!
  pat = [0 for x from 0 til 512]
  pat[2] = 1
  pat[8] = 1
  pat[32] = 1
  pat[128] = 1
  pat[18] = 1
  pat[24] = 1
  pat[48] = 1
  pat[144] = 1
  pat[130] = 1
  pat[40] = 1
  pat[56] = 1
  pat[146] = 1
  
  custom-pattern = ->
    pat = [0 for x from 0 til 512]
    pat[16] = 1
    pat[0] = 1
    pat[511] = 1
    pat[56] = 1
    pat[146] = 1
    pat[27] = 1
    pat[54] = 1
    pat[216] = 1
    pat[432] = 1
    pat[18] = 1
    pat[24] = 1
    pat[48] = 1
    pat[144] = 1
  #custom-pattern!
  */
