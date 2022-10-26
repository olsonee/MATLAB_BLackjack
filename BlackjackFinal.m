%Problems:  Aces,   Showing Figures(Kinda fixed?),  

clear 
clc
load CardDeck.mat
warning off
rng 'shuffle'
play = 'p';
done = 0;
wins = 0;
loses = 0;
draws = 0;
bank = 2000;
disp('Welcome to Blackjack, dealers hand is on the left, players hand is on the right. Good luck!')

%Runs Game Commands
Blackjack

%If player busts and still has money they can play again
while bank > 0
    %If player didnt want to play again in game commands
    %they wont be asked again
    if play == 'c'
        break
    end
    fprintf('You now have %d left in the bank. \n',bank)
    play = input('Play again? Insert (p), if not insert(c): ','s');
    while play ~= 'p' && play ~= 'c'
        play = input('Play again? Insert (p), if not insert(c): ','s');
        if play == 'p'
            Blackjack
        
            %If they dont hit play again game ends
        elseif play == 'c'
        
            %If play is not a character ask to play again
            break
        end
    end
end

