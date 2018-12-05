--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY hw_image_generator IS
--	GENERIC(
--		pixels_y :	INTEGER := 478;    --row that first color will persist until
--		pixels_x	:	INTEGER := 1000); 		--column that first color will persist until
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		moveUp          :	IN		STD_LOGIC;
		moveDown        :	IN		STD_LOGIC;
		moveLeft        :	IN		STD_LOGIC;
		moveRight       :	IN		STD_LOGIC;
		button          : IN    STD_LOGIC;
		
		
		clk : IN STD_LOGIC;
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

	signal i : std_logic_vector(12 downto 0);
	signal movingUp          :			STD_LOGIC := '0';
	signal movingDown        :			STD_LOGIC := '0';
	signal movingLeft        :			STD_LOGIC := '0';
	signal movingRight       :			STD_LOGIC := '0';
	signal gameOver        :			STD_LOGIC := '0';
	signal pixels_y   :	INTEGER := 750;   
	signal pixels_x	:	INTEGER := 750;
	signal x : INTEGER := 0;
	signal z : STD_LOGIC:= '1';
	signal snake_y : INTEGER :=1000;
	signal snake_x : INTEGER :=550;
	signal apple_x : INTEGER :=750;
	signal apple_y : INTEGER :=1000;
	signal nextapple_x : INTEGER :=500;
	signal nextapple_y : INTEGER :=750;
	signal bodyCount : INTEGER :=0;
	signal body_x1 : INTEGER :=0;
	signal body_y1 : INTEGER :=0;
	signal body_x2 : INTEGER :=0;
	signal body_y2 : INTEGER :=0;
	signal body_x3 : INTEGER :=0;
	signal body_y3 : INTEGER :=0;
	signal body_x4 : INTEGER :=0;
	signal body_y4 : INTEGER :=0;
	signal body_x5 : INTEGER :=0;
	signal body_y5 : INTEGER :=0;
	signal body_x6 : INTEGER :=0;
	signal body_y6 : INTEGER :=0;
	signal body_x7 : INTEGER :=0;
	signal body_y7 : INTEGER :=0;
	signal body_x8 : INTEGER :=0;
	signal body_y8 : INTEGER :=0;
	signal body_x9 : INTEGER :=0;
	signal body_y9 : INTEGER :=0;
	signal body_x10 : INTEGER :=0;
	signal body_y10 : INTEGER :=0;
	signal body_x11 : INTEGER :=0;
	signal body_y11 : INTEGER :=0;
	signal body_x12 : INTEGER :=0;
	signal body_y12 : INTEGER :=0;
	signal body_x13 : INTEGER :=0;
	signal body_y13 : INTEGER :=0;
	signal body_x14 : INTEGER :=0;
	signal body_y14 : INTEGER :=0;
	signal body_x15 : INTEGER :=0;
	signal body_y15 : INTEGER :=0;
	signal body_x16 : INTEGER :=0;
	signal body_y16 : INTEGER :=0;
	signal body_x17 : INTEGER :=0;
	signal body_y17 : INTEGER :=0;
	signal body_x18 : INTEGER :=0;
	signal body_y18 : INTEGER :=0;
	signal body_x19 : INTEGER :=0;
	signal body_y19 : INTEGER :=0;
	signal body_x20 : INTEGER :=0;
	signal body_y20 : INTEGER :=0;
	signal b : INTEGER :=26;
	signal currentsnake_y : INTEGER :=1000;
	signal currentsnake_x : INTEGER :=550;
	signal countDown : INTEGER := 0;
	signal count  : STD_LOGIC:= '0';
	
BEGIN
	

	PROCESS(count, countDown, body_x20, body_y20, body_x19, body_y19, body_x18, body_y18, body_x17, body_y17, body_x16, body_y16, body_x15, body_y15, body_x14, body_y14, body_x13, body_y13, body_x12, body_y12, body_x11, body_y11, body_x10, body_y10, body_x9, body_y9, body_x8, body_y8, body_x7, body_y7, body_x6, body_y6, body_x5, body_y5, body_x4, body_y4, body_x3, body_y3, body_x2, body_y2, currentsnake_y, currentsnake_x, bodyCount, body_x1, body_y1, b, gameOver, nextapple_x, nextapple_y, apple_x, apple_y, snake_x, snake_y, button, clk, i, disp_ena, row, column, moveUp, moveDown, moveLeft, moveRight, movingUp, movingDown, movingLeft, movingRight, x, pixels_y, pixels_x)
	BEGIN
	
	
	if(button = '0') THEN
	--clock
	if clk'event and clk = '1' then
		i<= i + 1;
			if (i>="1111111111110") THEN
				x <= x + 1;
				
				--generates the apple
				nextapple_x <= nextapple_x + 3;
				nextapple_y <= nextapple_y + 5;
				
				if nextapple_x > 750 then
					nextapple_x <= 350;
				end if;
		
				if nextapple_y > 1200 then
					nextapple_y <= 800;
				end if;
				
				i <= "0000000000000";
			end if;
		

		--gives movement information to following bodyparts
		if(b=25) then
		body_x20 <= body_x19;
		body_y20 <= body_y19;
		body_x19 <= body_x18;
		body_y19 <= body_y18;
		body_x18 <= body_x17;
		body_y18 <= body_y17;
		body_x17 <= body_x16;
		body_y17 <= body_y16;
		body_x16 <= body_x15;
		body_y16 <= body_y15;
		body_x15 <= body_x14;
		body_y15 <= body_y14;
		body_x14 <= body_x13;
		body_y14 <= body_y13;
		body_x13 <= body_x12;
		body_y13 <= body_y12;
		body_x12 <= body_x11;
		body_y12 <= body_y11;
		body_x11 <= body_x10;
		body_y11 <= body_y10;
		body_x10 <= body_x9;
		body_y10 <= body_y9;
		body_x9 <= body_x8;
		body_y9 <= body_y8;
		body_x8 <= body_x7;
		body_y8 <= body_y7;
		body_x7 <= body_x6;
		body_y7 <= body_y6;
		body_x6 <= body_x5;
		body_y6 <= body_y5;
		body_x5 <= body_x4;
		body_y5 <= body_y4;
		body_x4 <= body_x3;
		body_y4 <= body_y3;
		body_x3 <= body_x2;
		body_y3 <= body_y2;
		body_x2 <= body_x1;
		body_y2 <= body_y1;
		body_x1 <= currentsnake_x;
		body_y1 <= currentsnake_y;
		currentsnake_y <= snake_y;
		currentsnake_x <= snake_x;
		b<=0;
		
		end if;
		
			--slows the movement of the snake
			if(x>=160) THEN
			
			--increases the snake's body size if it eats an apple
		if snake_x > apple_x-30 AND snake_x < apple_x+20 AND snake_y > apple_y-30 AND snake_y < apple_y+20 then
			apple_x <= nextapple_x;
			apple_y <= nextapple_y;
			bodyCount <= bodyCount + 1;
		end if;
		
		if count ='1' then
			countDown <= countDown + 1;
		else
			countDown <= 0;
		end if;
		
		--causes the snake to move constantly after a button press
		if moveup = '0' AND gameOver = '0' AND movingDown = '0' then
			movingUp <= '1';
			movingDown <= '0';
			movingRight <= '0';
			movingLeft <= '0';
		
		elsif moveDown = '0' AND gameOver = '0' AND movingUp = '0' then
			movingUp <= '0';
			movingDown <= '1';
			movingRight <= '0';
			movingLeft <= '0';
	
		elsif moveLeft = '0' AND gameOver = '0' AND movingRight = '0' then
			movingUp <= '0';
			movingDown <= '0';
			movingRight <= '0';
			movingLeft <= '1';
	
		elsif moveRight = '0' AND gameOver = '0' AND movingLeft = '0' then
			movingUp <= '0';
			movingDown <= '0';
			movingRight <= '1';
			movingLeft <= '0';
		end if;
	
		--moves the snake and causes a game over if it goes to close to the edge
		if movingDown = '1' then
			snake_x <= snake_x+1;
			
			if (snake_x > 780) then
				gameOver <= '1';
			end if;
			
		end if;
		
		if movingUp = '1' then
			snake_x <= snake_x-1;
			
			if (snake_x <300) then
				gameOver <= '1';
			end if;
		end if;
			
		if movingLeft = '1' then
			snake_y <= snake_y-1;
			
			if (snake_y < 750) then
				gameOver <= '1';
			end if;
		end if;
			
		if movingRight = '1' then
			snake_y <= snake_y+1;
			
			if (snake_y > 1230) then
				gameOver <= '1';
			end if;
		end if;

	x<=0;
	b<= b + 1;
		
	end if;
	
		--causes a game over if you hit the tail
		if currentsnake_x > body_x5 AND currentsnake_x < body_x5+20 AND currentsnake_y > body_y5 AND currentsnake_y< body_y5+20 AND bodyCount>4 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		elsif currentsnake_x > body_x6 AND currentsnake_x < body_x6+20 AND currentsnake_y > body_y6 AND currentsnake_y< body_y6+20 AND bodyCount>5 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x7 AND currentsnake_x < body_x7+20 AND currentsnake_y > body_y7 AND currentsnake_y< body_y7+20 AND bodyCount>6 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x8 AND currentsnake_x < body_x8+20 AND currentsnake_y > body_y8 AND currentsnake_y< body_y8+20 AND bodyCount>7 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x9 AND currentsnake_x < body_x9+20 AND currentsnake_y > body_y9 AND currentsnake_y< body_y9+20 AND bodyCount>8 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x10 AND currentsnake_x < body_x10+20 AND currentsnake_y > body_y10 AND currentsnake_y< body_y10+20 AND bodyCount>9 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x11 AND currentsnake_x < body_x11+20 AND currentsnake_y > body_y11 AND currentsnake_y< body_y11+20 AND bodyCount>10 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x12 AND currentsnake_x < body_x12+20 AND currentsnake_y > body_y12 AND currentsnake_y< body_y12+20 AND bodyCount>11 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x13 AND currentsnake_x < body_x13+20 AND currentsnake_y > body_y13 AND currentsnake_y< body_y13+20 AND bodyCount>12 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x14 AND currentsnake_x < body_x14+20 AND currentsnake_y > body_y14 AND currentsnake_y< body_y14+20 AND bodyCount>13 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x15 AND currentsnake_x < body_x15+20 AND currentsnake_y > body_y15 AND currentsnake_y< body_y15+20 AND bodyCount>14 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x16 AND currentsnake_x < body_x16+20 AND currentsnake_y > body_y16 AND currentsnake_y< body_y16+20 AND bodyCount>15 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x17 AND currentsnake_x < body_x17+20 AND currentsnake_y > body_y17 AND currentsnake_y< body_y17+20 AND bodyCount>16 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x18 AND currentsnake_x < body_x18+20 AND currentsnake_y > body_y18 AND currentsnake_y< body_y18+20 AND bodyCount>17 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x19 AND currentsnake_x < body_x19+20 AND currentsnake_y > body_y19 AND currentsnake_y< body_y19+20 AND bodyCount>18 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		
		elsif currentsnake_x > body_x20 AND currentsnake_x < body_x20+20 AND currentsnake_y > body_y20 AND currentsnake_y< body_y20+20 AND bodyCount>19 then
			count <= '1';
			if countDown >10 then
				gameOver <= '1';
			end if;
		
		else
			count <= '0';
		end if;
		
			
	end if;
		
		
		--game over function
		if gameOver = '1'then
			movingUp <= '0';
			movingDown <= '0';
			movingRight <= '0';
			movingLeft <= '0';
			b <= 50;
		end if;
	
		--game win function
		if bodyCount>20 then
			gameOver <= '1';
		end if;
	
	--reset button
	ELSE
		currentsnake_y <= 1000;
		currentsnake_x <= 550;
		snake_y <= 1000;
		snake_x <= 550;
		movingUp <= '0';
		movingDown <= '0';
		movingRight <= '0';
		movingLeft <= '0';
		apple_x <= 750;
		apple_y <= 1000;
		gameOver <= '0';
		bodyCount <= 0;
		b <= 0;
	end IF;
		
		--arena display
		IF(disp_ena = '1') THEN		--display time
		
			IF(row>750 AND row<1250 AND column>300 AND column<800) THEN
				red <= (OTHERS => '0');
				green <= (OTHERS => '0');
				blue <= (OTHERS => '0');
			ELSIF(gameOver = '0') THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '1');
			ELSIF(bodyCount>17) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '1');
				blue <= (OTHERS => '0');
			ELSE
				red <= (OTHERS => '1');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			END IF;
		ELSE								--blanking time
			red <= (OTHERS => '0');
			green <= (OTHERS => '0');
			blue <= (OTHERS => '0');
		END IF;
		
		--snake display
		IF(disp_ena = '1') THEN		--display time
		
			IF(row > currentsnake_y AND row < currentsnake_y+20 And column < currentsnake_x+20 AND column > currentsnake_x) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '1');
				blue <= (OTHERS => '0');
			END IF;
			
			IF(bodyCount>0) then
				IF(row > body_y1 AND row < body_y1 +20 And column < body_x1 +20 AND column > body_x1 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>1) then
				IF(row > body_y2 AND row < body_y2 +20 And column < body_x2 +20 AND column > body_x2 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>2) then
				IF(row > body_y3 AND row < body_y3 +20 And column < body_x3 +20 AND column > body_x3 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>3) then
				IF(row > body_y4 AND row < body_y4 +20 And column < body_x4 +20 AND column > body_x4 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>4) then
				IF(row > body_y5 AND row < body_y5 +20 And column < body_x5 +20 AND column > body_x5 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>5) then
				IF(row > body_y6 AND row < body_y6 +20 And column < body_x6 +20 AND column > body_x6 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>6) then
				IF(row > body_y7 AND row < body_y7 +20 And column < body_x7 +20 AND column > body_x7 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>7) then
				IF(row > body_y8 AND row < body_y8 +20 And column < body_x8 +20 AND column > body_x8 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>8) then
				IF(row > body_y9 AND row < body_y9 +20 And column < body_x9 +20 AND column > body_x9 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>9) then
				IF(row > body_y10 AND row < body_y10 +20 And column < body_x10 +20 AND column > body_x10 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>10) then
				IF(row > body_y11 AND row < body_y11 +20 And column < body_x11 +20 AND column > body_x11 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>11) then
				IF(row > body_y12 AND row < body_y12 +20 And column < body_x12 +20 AND column > body_x12 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>12) then
				IF(row > body_y13 AND row < body_y13 +20 And column < body_x13 +20 AND column > body_x13 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>13) then
				IF(row > body_y14 AND row < body_y14 +20 And column < body_x14 +20 AND column > body_x14 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>14) then
				IF(row > body_y15 AND row < body_y15 +20 And column < body_x15 +20 AND column > body_x15 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>15) then
				IF(row > body_y16 AND row < body_y16 +20 And column < body_x16 +20 AND column > body_x16 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>16) then
				IF(row > body_y17 AND row < body_y17 +20 And column < body_x17 +20 AND column > body_x17 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>17) then
				IF(row > body_y18 AND row < body_y18 +20 And column < body_x18 +20 AND column > body_x18 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>18) then
				IF(row > body_y19 AND row < body_y19 +20 And column < body_x19 +20 AND column > body_x19 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
			IF(bodyCount>19) then
				IF(row > body_y20 AND row < body_y20 +20 And column < body_x20 +20 AND column > body_x20 ) THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				END IF;
			end if;
			
		END IF;
		
		
		IF(disp_ena = '1') THEN		--display time
		
			IF(row > apple_y AND row < apple_y+20 And column < apple_x+20 AND column > apple_x) THEN
				red <= (OTHERS => '1');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			END IF;
		END IF;
	
	END PROCESS;
END behavior;