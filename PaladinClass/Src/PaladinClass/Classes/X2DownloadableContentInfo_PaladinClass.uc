class X2DownloadableContentInfo_PaladinClass extends X2DownloadableContentInfo;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{}

/// <summary>
/// Called when all base game templates are loaded
/// </summary>
static event OnPostTemplatesCreated()
{
    `LOG("Battlefurying all known psi abilities");

	// try to apply battlefury to all known active psi abilities
	ApplyBattlefuryToAbility('Soulfire');
	ApplyBattlefuryToAbility('Stasis');
	ApplyBattlefuryToAbility('Insanity');
	ApplyBattlefuryToAbility('Inspire');
	ApplyBattlefuryToAbility('Fuse');
	ApplyBattlefuryToAbility('Domination');
	ApplyBattlefuryToAbility('NullLance');
	ApplyBattlefuryToAbility('VoidRift');
}

static function ApplyBattlefuryToAbility(name abilityName)
{
	local X2AbilityTemplate AbilityTemplate;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local bool UpdatedAbility;
	local int i;
	
	AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(abilityName);
	`LOG("Battlefurying " @ string(abilityName));

	// Find the action point cost. It's not always the first item, so find it in the list
	for (i = 0; i < AbilityTemplate.AbilityCosts.Length; i++)
	{
		ActionPointCost = X2AbilityCost_ActionPoints(AbilityTemplate.AbilityCosts[i]);
		if (ActionPointCost != none)
			break;
	}

	if (ActionPointCost == none)
	{
		`LOG("Paladin Class: Failed to apply Battlefury to ability template " @ string(abilityName) @ " (missing action point cost).");
		return;
	}

	// Determine if the ability's action point cost was already updated. This member of the X2AbilityCost_ActionPoints class
	// lists any abilities that will NOT consume action points as otherwise directed by the object
	UpdatedAbility = false;
	for (i = 0; i < ActionPointCost.DoNotConsumeAllSoldierAbilities.Length; i++)
	{
		if (ActionPointCost.DoNotConsumeAllSoldierAbilities[i] == 'Battlefury')
		{
			UpdatedAbility = true;
			break;
		}
	}

	// Update the ability's action point cost if the unit doesn't have Battlefury
	if (!UpdatedAbility)
	{
		ActionPointCost.iNumPoints = 1;
		ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('Battlefury');

		`LOG("Paladin Class: Applied Battlefury to ability template " @ string(abilityName) @ ".");
	}
	else
	{
		`LOG("Paladin Class: Couldn't apply Battlefury to ability template " @ string(abilityName) @ ". (already applied)");
	}
}