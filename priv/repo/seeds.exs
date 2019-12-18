alias Marbles.Competitor
alias Marbles.Event
alias Marbles.Marble
alias Marbles.Occasion
alias Marbles.OccasionEvent
alias Marbles.Team
alias Marbles.Repo

# --- OCCASIONS ---

ml2016 = %Occasion{name: "MarbleLympics 2016"} |> Repo.insert!()
ml2017 = %Occasion{name: "MarbleLympics 2017"} |> Repo.insert!()
ml2018 = %Occasion{name: "MarbleLympics 2018"} |> Repo.insert!()
ml2019 = %Occasion{name: "MarbleLympics 2019"} |> Repo.insert!()

# --- EVENTS ---

archery = %Event{name: "Archery"} |> Repo.insert!()
balancing = %Event{name: "Balancing"} |> Repo.insert!()
block_pushing = %Event{name: "Block Pushing"} |> Repo.insert!()
curling = %Event{name: "Curling"} |> Repo.insert!()
dirt_race = %Event{name: "Dirt Race"} |> Repo.insert!()
elimination_race = %Event{name: "Elimination Race"} |> Repo.insert!()
fidget_spinner_collision = %Event{name: "Fidget Spinner Collision"} |> Repo.insert!()
five_meter_ice_dash = %Event{name: "5 Meter Ice Dash"} |> Repo.insert!()
five_meter_sprint = %Event{name: "5 Meter Sprint"} |> Repo.insert!()
funnel_race = %Event{name: "Funnel Race"} |> Repo.insert!()
gravitrax_slalom = %Event{name: "Gravitrax Slalom"} |> Repo.insert!()
halfpipe = %Event{name: "Halfpipe"} |> Repo.insert!()
high_jump = %Event{name: "High Jump"} |> Repo.insert!()
hubelino_maze = %Event{name: "Hubelino Maze"} |> Repo.insert!()
hurdles_race = %Event{name: "Hurdles Race"} |> Repo.insert!()
long_jump = %Event{name: "Long Jump"} |> Repo.insert!()
rafting = %Event{name: "Rafting"} |> Repo.insert!()
relay_race = %Event{name: "Relay Race"} |> Repo.insert!()
sand_race = %Event{name: "Sand Race"} |> Repo.insert!()
snow_race = %Event{name: "Snow Race"} |> Repo.insert!()
steeplechase = %Event{name: "Steeplechase"} |> Repo.insert!()
summer_biathlon = %Event{name: "Summer Biathlon"} |> Repo.insert!()
underwater_race = %Event{name: "Underwater Race"} |> Repo.insert!()

# --- TEAMS ---

balls_of_chaos = %Team{name: "Balls of Chaos"} |> Repo.insert!()
chocolatiers = %Team{name: "Chocolatiers"} |> Repo.insert!()
crazy_cats_eyes = %Team{name: "Crazy Cat's Eyes"} |> Repo.insert!()
green_ducks = %Team{name: "Green Ducks"} |> Repo.insert!()
hazers = %Team{name: "Hazers"} |> Repo.insert!()
indigo_stars = %Team{name: "Indigo Stars"} |> Repo.insert!()
jungle_jumpers = %Team{name: "Jungle Jumpers"} |> Repo.insert!()
mellow_yellow = %Team{name: "Mellow Yellow"} |> Repo.insert!()
midnight_wisps = %Team{name: "Midnight Wisps"} |> Repo.insert!()
oceanics = %Team{name: "Oceanics"} |> Repo.insert!()
orangers = %Team{name: "O'rangers"} |> Repo.insert!()
pinkies = %Team{name: "Pinkies"} |> Repo.insert!()
raspberry_racers = %Team{name: "Raspberry Racers"} |> Repo.insert!()
savage_speeders = %Team{name: "Savage Speeders"} |> Repo.insert!()
team_galactic = %Team{name: "Team Galatic"} |> Repo.insert!()
thunderbolts = %Team{name: "Thunderbolts"} |> Repo.insert!()

# --- MARBLES ---

anarchy = %Marble{name: "Anarchy", team: balls_of_chaos} |> Repo.insert!()
tumult = %Marble{name: "Tumult", team: balls_of_chaos} |> Repo.insert!()
clutter = %Marble{name: "Clutter", team: balls_of_chaos} |> Repo.insert!()
snarl = %Marble{name: "Snarl", team: balls_of_chaos} |> Repo.insert!()
disarray = %Marble{name: "Disarray", team: balls_of_chaos} |> Repo.insert!()

red_eye = %Marble{name: "Red Eye", team: crazy_cats_eyes} |> Repo.insert!()
blue_eye = %Marble{name: "Blue Eye", team: crazy_cats_eyes} |> Repo.insert!()
yellow_eye = %Marble{name: "Yellow Eye", team: crazy_cats_eyes} |> Repo.insert!()
green_eye = %Marble{name: "Green Eye", team: crazy_cats_eyes} |> Repo.insert!()
cyan_eye = %Marble{name: "Cyan Eye", team: crazy_cats_eyes} |> Repo.insert!()

bonbon = %Marble{name: "Bonbon", team: chocolatiers} |> Repo.insert!()
choc = %Marble{name: "Choc", team: chocolatiers} |> Repo.insert!()

mallard = %Marble{name: "Mallard", team: green_ducks} |> Repo.insert!()
quacky = %Marble{name: "Quacky", team: green_ducks} |> Repo.insert!()

foggy = %Marble{name: "Foggy", team: hazers} |> Repo.insert!()
hazy = %Marble{name: "Hazy", team: hazers} |> Repo.insert!()

bingo = %Marble{name: "Bingo", team: indigo_stars} |> Repo.insert!()
indie = %Marble{name: "Indie", team: indigo_stars} |> Repo.insert!()

leap = %Marble{name: "Leap", team: jungle_jumpers} |> Repo.insert!()
skip = %Marble{name: "Skip", team: jungle_jumpers} |> Repo.insert!()

yellah = %Marble{name: "Yellah", team: mellow_yellow} |> Repo.insert!()
yellow = %Marble{name: "Yellow", team: mellow_yellow} |> Repo.insert!()

wespy = %Marble{name: "Wespy", team: midnight_wisps} |> Repo.insert!()
wispy = %Marble{name: "Wispy", team: midnight_wisps} |> Repo.insert!()

aqua = %Marble{name: "Aqua", team: oceanics} |> Repo.insert!()
ocean = %Marble{name: "Ocean", team: oceanics} |> Repo.insert!()

clementin = %Marble{name: "Clementin", team: orangers} |> Repo.insert!()
kinnowin = %Marble{name: "Kinnowin", team: orangers} |> Repo.insert!()

pinky_panther = %Marble{name: "Pinky Panther", team: pinkies} |> Repo.insert!()
pinky_winky = %Marble{name: "Pinky Winky", team: pinkies} |> Repo.insert!()

razzy = %Marble{name: "Razzy", team: raspberry_racers} |> Repo.insert!()
rezzy = %Marble{name: "Rezzy", team: raspberry_racers} |> Repo.insert!()

rapidly = %Marble{name: "Rapidly", team: savage_speeders} |> Repo.insert!()
speedy = %Marble{name: "Speedy", team: savage_speeders} |> Repo.insert!()

cosmo = %Marble{name: "Cosmo", team: team_galactic} |> Repo.insert!()
starry = %Marble{name: "Starry", team: team_galactic} |> Repo.insert!()

lightning = %Marble{name: "Lightning", team: thunderbolts} |> Repo.insert!()
shock = %Marble{name: "Shock", team: thunderbolts} |> Repo.insert!()

# --- MARBLELYMPICS 2019 ---

defmodule C do
  def comp(event, competitors) do
    Enum.each(Enum.with_index(competitors), fn {c, k} ->
      points = [25, 20, 15, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

      struct(Competitor, Map.merge(Map.merge(event, c), %{points: Enum.at(points, k)}))
      |> Repo.insert!()
    end)
  end
end

C.comp(
  %{
    occasion: ml2019,
    event: underwater_race
  },
  [
    %{team: savage_speeders, marble: rapidly, score: [1563, 1531, 1518]},
    %{team: green_ducks, marble: quacky, score: [1554, 1509, 1539]},
    %{team: chocolatiers, marble: choc, score: [1553, 1580, 1547]},
    %{team: hazers, marble: hazy, score: [1557, 1496, 1552]},
    %{team: raspberry_racers, marble: rezzy, score: [1541, 1513]},
    %{team: thunderbolts, marble: lightning, score: [1634, 1545]},
    %{team: team_galactic, marble: starry, score: [1634, 1607]},
    %{team: midnight_wisps, marble: wispy, score: [1544, 1608]},
    %{team: crazy_cats_eyes, marble: blue_eye, score: [1567]},
    %{team: indigo_stars, marble: bingo, score: [1573]},
    %{team: mellow_yellow, marble: yellow, score: [1580]},
    %{team: balls_of_chaos, marble: snarl, score: [1588]},
    %{team: oceanics, marble: ocean, score: [1601]},
    %{team: orangers, marble: kinnowin, score: [1636]},
    %{team: jungle_jumpers, marble: skip, score: [1657]},
    %{team: pinkies, marble: pinky_winky, score: [1662]}
  ]
)

C.comp(
  %{
    occasion: ml2019,
    event: funnel_race
  },
  [
    %{team: savage_speeders, marble: speedy, score: [6000 + 5432, 6000 + 6000 + 1107]},
    %{team: raspberry_racers, marble: razzy, score: [6000 + 6000 + 2058, 6000 + 6000 + 686]},
    %{team: hazers, marble: foggy, score: [6000 + 6000 + 1048, 6000 + 5673]},
    %{team: balls_of_chaos, marble: anarchy, score: [6000 + 4732, 6000 + 5124]},
    %{team: thunderbolts, marble: shock, score: [6000 + 5700, 6000 + 4580]},
    %{team: team_galactic, marble: cosmo, score: [6000 + 5432, 6000 + 4490]},
    %{team: green_ducks, marble: mallard, score: [6000 + 6000 + 322, 6000 + 4140]},
    %{team: jungle_jumpers, marble: leap, score: [6000 + 5387, 6000 + 3989]},
    %{team: mellow_yellow, marble: yellah, score: [6000 + 4206]},
    %{team: midnight_wisps, marble: wespy, score: [6000 + 3911]},
    %{team: pinkies, marble: pinky_panther, score: [6000 + 3887]},
    %{team: indigo_stars, marble: indie, score: [6000 + 3642]},
    %{team: chocolatiers, marble: bonbon, score: [6000 + 3451]},
    %{team: crazy_cats_eyes, marble: yellow_eye, score: [6000 + 3389]},
    %{team: oceanics, marble: aqua, score: [6000 + 3224]},
    %{team: orangers, marble: clementin, score: [-1]}
  ]
)

C.comp(
  %{
    occasion: ml2019,
    event: balancing
  },
  [
    %{team: hazers, marble: foggy, score: [71, 107, 130, 130, 438]},
    %{team: thunderbolts, marble: shock, score: [62, 101, 115, 130, 408]},
    %{team: crazy_cats_eyes, marble: yellow_eye, score: [36, 55, 130, 130, 351]},
    %{team: green_ducks, marble: mallard, score: [12, 32, 130, 130, 304]},
    %{team: team_galactic, marble: cosmo, score: [48, 58, 64, 130, 300]},
    %{team: mellow_yellow, marble: yellah, score: [31, 41, 71, 130, 273]},
    %{team: savage_speeders, marble: speedy, score: [37, 48, 53, 130, 268]},
    %{team: oceanics, marble: aqua, score: [17, 52, 80, 85, 234]},
    %{team: orangers, marble: clementin, score: [34, 47, 52, 93, 226]},
    %{team: midnight_wisps, marble: wespy, score: [16, 36, 38, 130, 220]},
    %{team: indigo_stars, marble: indie, score: [22, 26, 37, 130, 215]},
    %{team: balls_of_chaos, marble: anarchy, score: [44, 49, 53, 64, 210]},
    %{team: pinkies, marble: pinky_panther, score: [18, 31, 48, 103, 200]},
    %{team: raspberry_racers, marble: razzy, score: [37, 42, 50, 70, 199]},
    %{team: chocolatiers, marble: bonbon, score: [19, 30, 32, 91, 172]},
    %{team: jungle_jumpers, marble: leap, score: [17, 34, 49, 54, 154]}
  ]
)

%OccasionEvent{occasion: ml2019, date: ~D[2019-04-19], event: underwater_race} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-04-23], event: funnel_race} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-04-26], event: balancing} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-04-30], event: gravitrax_slalom} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-05-03], event: five_meter_sprint} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-05-07], event: relay_race} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-05-10], event: block_pushing} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-05-07], event: summer_biathlon} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-05-17], event: hurdles_race} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-05-21], event: hubelino_maze} |> Repo.insert!()
%OccasionEvent{occasion: ml2019, date: ~D[2019-05-24], event: dirt_race} |> Repo.insert!()
# %OccasionEvent{occasion: ml2019, date: ~D[2019-01-01], event: rafting} |> Repo.insert!()
# %OccasionEvent{occasion: ml2019, date: ~D[2019-01-01], event: elimination_race} |> Repo.insert!()

ml2019_pre = Repo.preload(ml2019, [:teams])

Ecto.Changeset.change(ml2019_pre)
|> Ecto.Changeset.put_assoc(:teams, [
  balls_of_chaos,
  chocolatiers,
  crazy_cats_eyes,
  green_ducks,
  hazers,
  indigo_stars,
  jungle_jumpers,
  mellow_yellow,
  midnight_wisps,
  oceanics,
  orangers,
  pinkies,
  raspberry_racers,
  savage_speeders,
  team_galactic,
  thunderbolts
])
|> Repo.update!()

# --- CHANGESETS ---

Ecto.Changeset.change(Repo.preload(ml2017, [:events]))
|> Ecto.Changeset.put_assoc(:events, [
  funnel_race,
  long_jump,
  fidget_spinner_collision,
  five_meter_sprint,
  hurdles_race,
  relay_race,
  block_pushing,
  high_jump,
  steeplechase,
  archery,
  underwater_race,
  sand_race
])
|> Repo.update!()

# Ecto.Changeset.change(Repo.preload(ml2018, [:events]))
# |> Ecto.Changeset.put_assoc(:events, [
#   five_meter_ice_dash,
#   ski_jump,
#   halfpipe,
#   bobsleigh,
#   speed_skating,
#   team_pursuit,
#   snow_rally,
#   snowboard_cross,
#   curling,
#   gravitrax_biathlon,
#   ice_hockey,
#   sand_mogul_race,
# ])
# |> Repo.update!()
