string getCurrentMapId()
{

	auto app = cast<CTrackMania>(GetApp());
	return app.RootMap.MapInfo.MapUid;
}

float calcPercentage(const int &in pos, const int &in total) {
	return float(int(((float(pos) / float(total)) * 100.0) * 100.0)) / 100.0;
}

bool isPlayerInGame()
{
	try
	{
		auto app = cast<CTrackMania>(GetApp());
		return !(app.RootMap is null) && app.Editor is null;
	}
	catch 
	{
		return false;
	}
}


int getRankFromTime(const string &in mapId, int time)
{
    auto req = Net::HttpRequest();
    req.Url = "https://map-monitor.xk.io/map/"+mapId+"/"+time+"/refresh";
    req.Method = Net::HttpMethod::Get;

    req.Start();
    while(!req.Finished()){
        yield();
    }

    auto response = Json::Parse(req.String())["tops"][0]["top"][0]["position"];

    return response;
}






