%Runs player actions for BlackjackFinal.m 
%Assembly by Eagan Olson

%Loops the game while player selects play
while play == 'p'
    
    %Shuffles Cards and deals them
    ShuffledCards = randperm(52);
    CardValues = [11,2:10,10,10,10,11,2:10,10,10,10,11,2:10,10,10,10,11,2:10,10,10,10];
    CardValuesAce = [1:10,10,10,10,1:10,10,10,10,1:10,10,10,10,1:10,10,10,10];
    Hand = ShuffledCards(1:2:3);
    Dealer = [ShuffledCards(2) ShuffledCards(4)];
    fprintf('\nYou have %d in the bank\n',bank)
    bet = input('How much would you like to bet? ');
    PlayerValue = sum(CardValues(Hand));
    DealerValue = sum(CardValues(Dealer));

    %Checks bet
    while bet > bank || bet < 1
        bet = input('Invalid bet, How much would you like to bet? ');
    end

    %Shows cards
    set(0,'DefaultFigureWindowStyle','docked')
    figure;
    gcf;
    imshow([RedDeck{Dealer(1)},RedDeck{55},Blank,Blank,RedDeck{Hand}]);

    %Check if both have Blackjack
    if sum(CardValues(Hand)) == 21 && sum(CardValues(Dealer)) == 21
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        disp('Push!')
        draws = draws + 1;
        fprintf('You have %d in the bank',bank)
        break
        
        %Dealer Blackjack check
    elseif sum(CardValues(Dealer)) == 21
        disp('Dealer Blackjack!')
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        bank = bank - bet;
        loses = loses + 1;
        fprintf('You now have %d left in the bank',bank)
        break
        
        %Player Blackjack check
    elseif sum(CardValues(Hand)) == 21
        disp('Blackjack!')
        bank = bank + (bet * 1.5);
        wins = wins + 1;
        fprintf('You now have %d in the bank',bank)
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        break
    end

    %The next card delt is the 5th card in the deck
    n = 5;

    %Player's turn
    choice = input('\n Would you like to Hit(h), Stand(s), or Double(d): ','s');
    if choice ~= 'h' && choice ~= 's' && choice ~= 'd'
        choice = input('\n Input not accept please choose to Hit(h) Stand(s), or Double(d): ','s');
    end

    %If player doubles
    while choice == 'd'

        %Double the Bet
        bet = bet * 2;             
        
        %Check if can afford double
            while bet > bank
                disp('Cannot afford to double');
                choice = input('\n Would you like to Hit(h) or Stand(s): ','s');
                bet = bet / 2;
                done = 1;
                break
            end
            if done == 1
                break
            end
            
        %Runs double function
        fprintf('Bet is now %d\n',bet)
        Hand = [Hand ShuffledCards(n)];
        imshow([RedDeck{Dealer(1)},RedDeck{55},Blank,Blank,RedDeck{Hand}]);
        n = n + 1;
        
        %Aces Check
        if sum(CardValues(Hand)) > 21
            %Card Values are now the Aces Value not regular
            
            %Check if player bust
            if sum(CardValuesAce(Hand)) > 21
                PlayerValue = 0;
                disp('Bust!');
                bank = bank - bet;
                loses = loses + 1;
                fprintf('You now have %d left in the bank',bank)
                bust = 1;
                break
            end
            PlayerValue = sum(CardValuesAce(Hand));
            choice = 's';
        
        else 
            PlayerValue = sum(CardValues(Hand));
            choice = 's';
        end
    end
    
    %Special case break statement incase player doubles and busts
    if bust == 1
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        break
    end

    %Resets break statement
    done = 0;

    %Player Hits
    while choice == 'h'
        Hand = [Hand ShuffledCards(n)];
        imshow([RedDeck{Dealer(1)},RedDeck{55},Blank,Blank,RedDeck{Hand}]);
        n = n + 1;

        %Aces Check
        if sum(CardValues(Hand)) > 21
            %Card Values switch to the Aces value now
            
            %Check for bust
            if sum(CardValuesAce(Hand)) > 21
                PlayerValue = 0;
                disp('Bust!');
                bank = bank - bet;
                loses = loses + 1;
                fprintf('You now have %d left in the bank',bank)
                done = 1;
                break
            elseif sum(CardValuesAce(Hand)) == 21
                PlayerValue = sum(CardValuesAce(Hand));
                break
            end
            PlayerValue = sum(CardValuesAce(Hand));
        end

        %If player gets 21 turn ends
        if sum(CardValues(Hand)) == 21
            PlayerValue = sum(CardValues(Hand));
            break
        end
 
        choice = input('\n Would you like to Hit(h) or Stand(s): ','s');
        if choice ~= 'h' && choice ~= 's'
            choice = input('\n Input not accepted please choose to Hit(h) or Stand(s): ','s');
        end
        PlayerValue = sum(CardValues(Hand));
    end

    %Ends game if bust on hit
    if done == 1
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        break
    end

    %Dealer Turn
    while sum(CardValues(Dealer)) < 17
        Dealer = [Dealer, ShuffledCards(n)];

         %Aces Check
        if sum(CardValues(Dealer)) > 21
            %Card Value switches to Aces value now
            
            %Check if dealer bust
            if sum(CardValuesAce(Dealer)) > 21
                imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
                DealerValue = 0;
                disp('Dealer Busts!');
                bank = bank + bet;
                wins = wins + 1;
                fprintf('You now have %d in the bank.',bank)
                done = 1;
                break
            end
            DealerValue = sum(CardValuesAce(Dealer));
        end
        n = n + 1;
        DealerValue = sum(CardValues(Dealer));
    end

    %If dealer busts game ends
    if done == 1
        break
    end

    %If player hand is the same as dealer hand you push
    if PlayerValue == DealerValue  
        disp('Push!')    
        draws = draws + 1;
        fprintf('You have %d in the bank',bank)
    
        %if player hand is greater player wins
    elseif PlayerValue > DealerValue
        disp('You Win!')
        bank = bank + bet;
        wins = wins + 1;
        fprintf('You now have %d in the bank',bank)

            %If dealer hand is greater dealer wins
    elseif PlayerValue < DealerValue
        disp('You Lose!')
        bank = bank - bet;
        loses = loses + 1;
        fprintf('You now have %d left in the bank. \n',bank)
    end
    imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);

    %If player doesnt have money left game ends
    if bank == 0 
        disp('You are out of money. Have a nice day!')
        break
    end

    play = input('\nPlay again? Insert (p), if not insert(c): ','s');
    while play ~= 'p' && play ~= 'c'
        play = input('Play again? Insert (p), if not insert(c): ','s');
        if play == 'c'
            done = 1;
            break
        end
    end
    
    %Displays wins, loses, and draws
    fprintf('\nYou have won %d times. \n',wins)
    fprintf('You have lost %d times. \n',loses)
    fprintf('You pushed %d times. \n',draws)
end

   
    