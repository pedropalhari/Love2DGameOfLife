-- Load some default values for our rectangle.
function love.load()
  x, y, w, h = 10, 10, 10, 10
  print("a")

  love.graphics.setBackgroundColor(1, 1, 1);

  mapa = {};
  mapaNext = {};

  -- inicializa 40x40 com 0
  inicializaMapas(mapa, mapaNext);

  mapa[3][5] = 1;
  mapa[4][5] = 1;
  mapa[5][5] = 1;
  mapa[5][4] = 1;
  mapa[4][3] = 1;

  -- controlar o tempo dos turnos
  currentTime = 0;
  tempoDoTurno = 0.5;
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
  currentTime = currentTime + dt;

  if(currentTime >= tempoDoTurno) then
    currentTime = currentTime - tempoDoTurno;

    rodaTurno();
  end
end

-- aplica as regras do jogo da vida
function rodaTurno()
  for i = 1, 40 do
    for j = 1, 40 do
      local counter = 0;

      if(i + 1 <= 40 and mapa[i + 1][j] == 1) then
        counter = counter + 1;
      end

      if(i - 1 >= 1 and mapa[i - 1][j] == 1) then
        counter = counter + 1;
      end

      if(j + 1 <= 40 and mapa[i][j + 1] == 1) then
        counter = counter + 1;
      end

      if(j - 1 >= 1 and mapa[i][j - 1] == 1) then
        counter = counter + 1;
      end

      if(i + 1 <= 40 and j + 1 <= 40 and mapa[i + 1][j + 1] == 1) then
        counter = counter + 1;
      end

      if(i + 1 <= 40 and j - 1 >= 1 and mapa[i + 1][j - 1] == 1) then
        counter = counter + 1;
      end

      if(i - 1 >= 1 and j + 1 <= 40 and mapa[i - 1][j + 1] == 1) then
        counter = counter + 1;
      end

      if(i - 1 >= 1 and j - 1 >= 1 and mapa[i - 1][j - 1] == 1) then
        counter = counter + 1;
      end

      if(mapa[i][j] == 1 and counter < 2) then -- morre
        mapaNext[i][j] = 0;
      end

      if(mapa[i][j] == 1 and counter >= 4) then -- morre
        mapaNext[i][j] = 0;
      end

      if(mapa[i][j] == 0 and counter == 3) then -- nasce
        mapaNext[i][j] = 1;
      end

      if(mapa[i][j] == 1 and (counter == 2 or counter == 3)) then -- continua
        mapaNext[i][j] = 1;
      end

      -- print(i .. ', ' .. j .. ': ' .. counter);
    end
  end

  for i = 1, 40 do
    for j = 1, 40 do
      mapa[i][j] = mapaNext[i][j];
    end
  end
end

-- desenha na posição
function love.draw()
  love.graphics.setColor(0, 0, 0)
  

  for i = 1, 40 do
    for j = 1, 40 do
      if(mapa[i][j] == 1) then
        love.graphics.rectangle("fill", (i - 1) * 10, (j - 1) * 10, w, h);
      end
    end
  end
end

function inicializaMapas(mapa, mapaNext)
  for i = 1, 40 do
    local mapaAux = {};
    local mapaNextAux = {};

    for j = 1, 40 do
      mapaAux[j] = 0;
      mapaNextAux[j] = 0;
    end

    mapa[i] = mapaAux;
    mapaNext[i] = mapaNextAux;
  end
end