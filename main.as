bool showUI = false;

void addAudiences()
{
	NadeoServices::AddAudience("NadeoLiveServices");
	NadeoServices::AddAudience("NadeoClubServices");
	while (!NadeoServices::IsAuthenticated("NadeoClubServices") && !NadeoServices::IsAuthenticated("NadeoLiveServices")){yield();}
}

class Medal {
	string name;
	int time;
	float percent;
	bool rdy;
	bool show;
	string color;
	
	Medal(const string &in name="", const string &in color="$000", int time=0, float percent=0, bool rdy=false, bool show=true){
		this.name = name;
		this.time = time;
		this.percent = percent;
		this.rdy = rdy;
		this.show = show;
		this.color = color;
	}
}

auto author = Medal("Author", "$071");
auto gold = Medal("Gold", "$db4");
auto silver = Medal("Silver", "$899");
auto bronze = Medal("Bronze", "$964");

array<Medal@> medals = {author, gold, silver, bronze};

void Main()
{

	auto cpt = 0;	
	string oldMapId = "";

	addAudiences();
	while (true)
	{
		auto playerInGame = isPlayerInGame();
		{
			if (playerInGame)
			{
				string mapId = getCurrentMapId();

				if (mapId != oldMapId || cpt > 900)
				{

					auto app = cast<CTrackMania>(GetApp());
					auto map = app.RootMap;

					author.time = map.TMObjective_AuthorTime;
					gold.time = map.TMObjective_GoldTime;
					silver.time = map.TMObjective_SilverTime;
					bronze.time = map.TMObjective_BronzeTime;

					auto playerCount = getRankFromTime(mapId, 999999999);

					showUI = true;

					for(int i=0;i<4;i++){
						medals[i].percent = calcPercentage(getRankFromTime(mapId, medals[i].time), playerCount);
						medals[i].rdy = true;
					}
					

					oldMapId = mapId;
					cpt = 0;
				}

			}
			else 
			{
				showUI = false;
				for(int i=0;i<4;i++){
					medals[i].rdy = false;
				}
				oldMapId = "";
			}
		
		sleep(1000);
		cpt+=1;
	}
	}
}

