program ResourceClicker;

uses
  SysUtils, CRT;

const
  INITIAL_RESOURCE_RATE = 1; // Initial resource generation rate per second
  UPGRADE_COST = 10; // Cost of upgrading resource generation rate
  UPGRADE_MULTIPLIER = 2; // Multiplier for resource generation rate upon upgrade

var
  resources: Integer; // Current amount of resources
  resourceRate: Integer; // Current resource generation rate per second
  lastUpdateTime: LongInt; // Time of the last update

// Function to update the game state
procedure UpdateGameState;
var
  currentTime: LongInt;
  elapsedTime: Integer;
begin
  currentTime := Round(1000 * (Now - EncodeDate(2024, 1, 1))); // Current time in milliseconds since game start
  elapsedTime := currentTime - lastUpdateTime; // Time elapsed since last update

  resources := resources + resourceRate * (elapsedTime div 1000); // Update resources based on resource generation rate

  lastUpdateTime := currentTime; // Update last update time
end;

// Function to display the game UI
procedure DisplayUI;
begin
  ClrScr;
  WriteLn('Resource Clicker');
  WriteLn('----------------');
  WriteLn('Resources: ', resources);
  WriteLn('Resource Generation Rate: ', resourceRate, ' per second');
  WriteLn;
  WriteLn('Options:');
  WriteLn('1. Click to Collect Resources');
  WriteLn('2. Upgrade Resource Generation Rate (Cost: ', UPGRADE_COST, ' resources)');
  WriteLn('3. Quit');
end;

// Function to handle player input
procedure HandleInput;
var
  choice: Integer;
begin
  Write('Enter your choice: ');
  ReadLn(choice);
  
  case choice of
    1: resources := resources + 1; // Click to collect resources
    2: begin // Upgrade resource generation rate
         if resources >= UPGRADE_COST then
         begin
           resources := resources - UPGRADE_COST;
           resourceRate := resourceRate * UPGRADE_MULTIPLIER;
           UPGRADE_COST := Round(UPGRADE_COST * 1.5); // Increase upgrade cost for next upgrade
         end
         else
           WriteLn('Insufficient resources to upgrade!');
       end;
    3: Halt; // Quit the game
    else
      WriteLn('Invalid choice. Please try again.');
  end;
end;

// Main game loop
procedure GameLoop;
var
  currentTime: LongInt;
begin
  lastUpdateTime := Round(1000 * (Now - EncodeDate(2024, 1, 1))); // Initialize last update time
  while True do
  begin
    currentTime := Round(1000 * (Now - EncodeDate(2024, 1, 1))); // Current time in milliseconds since game start
    if currentTime - lastUpdateTime >= 1000 then // Update game state every second
    begin
      UpdateGameState;
      DisplayUI;
    end;
    HandleInput;
  end;
end;

// Main program
begin
  resources := 0;
  resourceRate := INITIAL_RESOURCE_RATE;
  GameLoop;
end.
