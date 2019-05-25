alias Marbles.Competitor
alias Marbles.Event
alias Marbles.Marble
alias Marbles.Occasion
alias Marbles.Team
alias Marbles.Repo

ml2016 = %Occasion{name: "MarbleLympics 2016"} |> Repo.insert!()
ml2017 = %Occasion{name: "MarbleLympics 2017"} |> Repo.insert!()
ml2018 = %Occasion{name: "MarbleLympics 2018"} |> Repo.insert!()
ml2019 = %Occasion{name: "MarbleLympics 2019"} |> Repo.insert!()

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

balls = %Team{name: "Balls of Chaos"} |> Repo.insert!()
crazy = %Team{name: "Crazy Cat's Eyes"} |> Repo.insert!()

%Marble{name: "Anarchy", team: balls} |> Repo.insert!()
%Marble{name: "Tumult", team: balls} |> Repo.insert!()
%Marble{name: "Clutter", team: balls} |> Repo.insert!()
snarl = %Marble{name: "Snarl", team: balls} |> Repo.insert!()
%Marble{name: "Disarray", team: balls} |> Repo.insert!()

%Marble{name: "Red Eye", team: crazy} |> Repo.insert!()
%Marble{name: "Blue Eye", team: crazy} |> Repo.insert!()
%Marble{name: "Yellow Eye", team: crazy} |> Repo.insert!()
%Marble{name: "Green Eye", team: crazy} |> Repo.insert!()
%Marble{name: "Cyan Eye", team: crazy} |> Repo.insert!()

%Competitor{
  occasion: ml2019,
  event: underwater_race,
  team: balls,
  marble: snarl,
  score: 1588,
  points: 4
}
|> Repo.insert!()

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

ml2019_pre = Repo.preload(ml2019, [:events, :teams])

Ecto.Changeset.change(ml2019_pre)
|> Ecto.Changeset.put_assoc(:events, [
  underwater_race,
  funnel_race,
  balancing,
  gravitrax_slalom,
  five_meter_sprint,
  relay_race,
  block_pushing,
  summer_biathlon,
  hurdles_race,
  hubelino_maze,
  dirt_race,
  rafting,
  elimination_race
])
|> Repo.update!()

Ecto.Changeset.change(ml2019_pre)
|> Ecto.Changeset.put_assoc(:teams, [
  balls,
  crazy
])
|> Repo.update!()
