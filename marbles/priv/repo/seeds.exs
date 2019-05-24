alias Marbles.Events.Event
alias Marbles.Marbles.Marble
alias Marbles.Occasions.Occasion
alias Marbles.Teams.Team
alias Marbles.Repo

%Occasion{name: "MarbleLympics 2016"} |> Repo.insert!()
%Occasion{name: "MarbleLympics 2017"} |> Repo.insert!()
%Occasion{name: "MarbleLympics 2018"} |> Repo.insert!()
ml2019 = %Occasion{name: "MarbleLympics 2019"} |> Repo.insert!()

underwater_race = %Event{name: "Underwater Race"} |> Repo.insert!()
funnel_race = %Event{name: "Funnel Race"} |> Repo.insert!()
balancing = %Event{name: "Balancing"} |> Repo.insert!()
gravitrax_slalom = %Event{name: "Gravitrax Slalom"} |> Repo.insert!()
five_meter_sprint = %Event{name: "5 Meter Sprint"} |> Repo.insert!()
relay_run = %Event{name: "Relay Run"} |> Repo.insert!()
block_pushing = %Event{name: "Block Pushing"} |> Repo.insert!()
summer_biathlon = %Event{name: "Summer Biathlon"} |> Repo.insert!()
hurdles_race = %Event{name: "Hurdles Race"} |> Repo.insert!()
hubelino_maze = %Event{name: "Hubelino Maze"} |> Repo.insert!()
dirt_race = %Event{name: "Dirt Race"} |> Repo.insert!()
rafting = %Event{name: "Rafting"} |> Repo.insert!()
elimination_race = %Event{name: "Elimination Race"} |> Repo.insert!()

Ecto.Changeset.change(Repo.preload(ml2019, [:events]))
|> Ecto.Changeset.put_assoc(:events, [
  underwater_race,
  funnel_race,
  balancing,
  gravitrax_slalom,
  five_meter_sprint,
  relay_run,
  block_pushing,
  summer_biathlon,
  hurdles_race,
  hubelino_maze,
  dirt_race,
  rafting,
  elimination_race
])
|> Repo.update!()

balls = %Team{name: "Balls of Chaos"} |> Repo.insert!()
crazy = %Team{name: "Crazy Cat's Eyes"} |> Repo.insert!()

%Marble{name: "Anarchy", team: balls} |> Repo.insert!()
%Marble{name: "Tumult", team: balls} |> Repo.insert!()
%Marble{name: "Clutter", team: balls} |> Repo.insert!()
%Marble{name: "Snarl", team: balls} |> Repo.insert!()
%Marble{name: "Disarray", team: balls} |> Repo.insert!()
