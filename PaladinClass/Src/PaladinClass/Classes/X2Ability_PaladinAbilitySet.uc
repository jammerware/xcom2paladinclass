class X2Ability_PaladinAbilitySet extends X2Ability
	config(PaladinClass);

var name BattlefuryAbilityName;

static function array <X2DataTemplate> CreateTemplates()
{
	// TODO: expose values and strings to config and localization, respectively, sort of like this:
	// var config int ParallaxCooldown;
	// var localized string ParallaxFriendlyName;
	
	local array<X2DataTemplate> Templates;
	Templates.Length = 0;

	// SQUADDIE!
	Templates.AddItem(PurePassive(default.BattlefuryAbilityName));

	`LOG("Paladin Class: Creating templates - " @ string(Templates.Length));
	return Templates;
}

DefaultProperties
{
	BattlefuryAbilityName="Battlefury"
}