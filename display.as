void displayUI()
{

	if (showUI)
	{

		author.show = settings_showAuthor;
		gold.show = settings_showGold;
		silver.show = settings_showSilver;
		bronze.show = settings_showBronze;

		UI::Begin(ColoredString("$EEEPercentile"), 65);

		UI::BeginTable("table", 4);

		UI::TableNextRow();

		UI::TableNextColumn();
		UI::Text("");

		for(int i=0;i<4;i++){
			if (medals[i].show){
				UI::Text(ColoredString(medals[i].color + Icons::Circle));
			}
		}

		UI::TableNextColumn();
		UI::Text("Medal");
		for(int i=0;i<4;i++){
			if (medals[i].show){
				UI::Text(medals[i].name);
			}
		}

		UI::TableNextColumn();
		if (settings_showTimeColumn)
		{
			UI::Text("Time");
		for(int i=0;i<4;i++){
			if (medals[i].show){
				UI::Text(Time::Format(medals[i].time));
			}
		}


		UI::TableNextColumn();
		}
		UI::Text("Players");

		for(int i=0;i<4;i++){
			if (medals[i].show){
				if (medals[i].rdy){
					UI::Text(medals[i].percent+" %");
				}
				else{
					UI::Text("LOADING");
				}
			}
		}
		UI::EndTable();
		UI::End();
	}
}

void Render()
{
	if (!(settings_hideWhenFocus && !UI::IsGameUIVisible() || settings_hideWhenNotOverlay && !UI::IsOverlayShown()))
	{
		displayUI();
	}
}


