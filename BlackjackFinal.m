clear 
clc
load CardDeck.mat
warning off
rng 'shuffle'
play = 'p';
done = 0;
bust = 0;
wins = 0;
loses = 0;
draws = 0;
bank = 2000;
disp('Welcome to Blackjack, dealers hand is on the left, players hand is on the right. Good luck!')

%Runs Game Commands
BlackjackPlayer

%Reset break condition
done = 0;

%If player busts and still has money they can play again
while bank > 0
    %If player didnt want to play again in game commands
    %they wont be asked again
    if play == 'c'
        break
    end
    fprintf('\n\nYou have %d left in the bank. \n',bank)
    play = input('Play again? Insert (p), if not insert(c): ','s');
    
    %Checking for valid inputs
    while play ~= 'p' && play ~= 'c'
        play = input('Play again? Insert (p), if not insert(c): ','s');
        if play == 'p'
            BlackjackPlayer
        
            %If they dont hit play again game ends
        elseif play == 'c'
        
            %If play is not a character ask to play again
            break
        end
    end
    if play == 'p'
        BlackjackPlayer
    end
end

