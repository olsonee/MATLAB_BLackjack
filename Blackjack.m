%Problems: 
%First figure doesnt load until game ends

%Loops the game while player selects play
while play == 'p'
    
    %Shuffles Cards and deals them
    ShuffledCards = randperm(52);
    CardValues = [11,2:10,10,10,10,11,2:10,10,10,10,11,2:10,10,10,10,11,2:10,10,10,10];
    Hand = ShuffledCards(1:2:3);
    Dealer = [ShuffledCards(2) ShuffledCards(4)];
    fprintf('\nYou have %d in the bank\n',bank)
    bet = input('How much would you like to bet? ');
    PlayerValue = sum(CardValues(Hand));

    %Checks bet
    while bet > bank || bet < 1
        bet = input('Invalid bet, How much would you like to bet? ');
    end

    %Shows cards
    set(0,'DefaultFigureWindowStyle','docked')
    figure;
    gcf;
    imshow([RedDeck{Dealer(1)},RedDeck{55},Blank,Blank,RedDeck{Hand}]);


    %Check if Blackjack
    if PlayerValue == 21 && sum(CardValues(Dealer)) == 21
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        disp('Push!')
        draws = draws + 1;
        fprintf('You have %d in the bank',bank)
        break
        %Dealer Blackjack
    elseif sum(CardValues(Dealer)) == 21
        disp('Dealer Blackjack!')
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        bank = bank - bet;
        loses = loses + 1;
        fprintf('You now have %d left in the bank',bank)
        break
        %Player Blackjack
    elseif PlayerValue == 21
        disp('Blackjack!')
        bank = bank + (bet * 1.5);
        wins = wins + 1;
        fprintf('You now have %d in the bank',bank)
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        break
    end

    %The next card is the 5th card in the deck
    counter = 5;

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
        n = counter;
        Hand = [Hand ShuffledCards(n)];
        imshow([RedDeck{Dealer(1)},RedDeck{55},Blank,Blank,RedDeck{Hand}]);
        counter = counter + 1;
        
        %Aces Check
        if PlayerValue > 21
            CardValues = [1:10,10,10,10,1:10,10,10,10,1:10,10,10,10,1:10,10,10,10];
            
            %Check if player bust
            if PlayerValue > 21
                CardValues(Hand) = 0;
                disp('Bust!');
                bank = bank - bet;
                loses = loses + 1;
                fprintf('You now have %d left in the bank',bank)
                break
            end
            PlayerValue = sum(CardValues(Hand));
        end
        choice = 's';
    end
    
    %Resets break statement
    done = 0;

    %Player Hits
    while choice == 'h'
        n = counter;
        Hand = [Hand ShuffledCards(n)];
        imshow([RedDeck{Dealer(1)},RedDeck{55},Blank,Blank,RedDeck{Hand}]);
        counter = counter + 1;

        %Aces Check
        if PlayerValue > 21
            
            %Aces value = 1 instead of 11
            CardValues = [1:10,10,10,10,1:10,10,10,10,1:10,10,10,10,1:10,10,10,10];
            
            %Check for bust
            if PlayerValue > 21
                PlayerValue = 0;
                disp('Bust!');
                bank = bank - bet;
                loses = loses + 1;
                fprintf('You now have %d left in the bank',bank)
                break
            elseif sum(CardValues(Hand)) == 21
                PlayerValue = sum(CardValues(Hand));
                break
            end
            PlayerValue = sum(CardValues(Hand));
        end
 
        choice = input('\n Would you like to Hit(h) or Stand(s): ','s');
        if choice ~= 'h' && choice ~= 's'
            choice = input('\n Input not accepted please choose to Hit(h) or Stand(s): ','s');
        end
        PlayerValue = sum(CardValues(Hand));
    end

    %Resets Card Values for dealer
    CardValues = [11,2:10,10,10,10,11,2:10,10,10,10,11,2:10,10,10,10,11,2:10,10,10,10];

    %Ends game if bust on hit
    if done == 1
        imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
        break
    end

    %Dealer Turn
    while sum(CardValues(Dealer)) < 17
        n = counter;
        Dealer = [Dealer ShuffledCards(n)];

        %Check Dealer bust
        if sum(CardValues(Dealer)) > 21
            imshow([RedDeck{Dealer},Blank,Blank,RedDeck{Hand}]);
            CardValues(Dealer) = 0;
            disp('Dealer Bust!');
            bank = bank + bet;
            wins = wins + 1;
            done = 1;
            break  %PLAYER WIN!!! 
        end
        counter = counter + 1;
    end

    %If dealer busts game ends
    if done == 1
        break
    end

    %If player hand is the same as dealer hand you push
    if PlayerValue == sum(CardValues(Dealer))   
        disp('Push!')    
        draws = draws + 1;
        fprintf('You have %d in the bank',bank)
    
        %if player hand is greater player wins
    elseif PlayerValue > sum(CardValues(Dealer))
        disp('You Win!')
        bank = bank + bet;
        wins = wins + 1;
        fprintf('You now have %d in the bank',bank)

            %If dealer hand is greater dealer wins
    elseif PlayerValue < sum(CardValues(Dealer))
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

   
    