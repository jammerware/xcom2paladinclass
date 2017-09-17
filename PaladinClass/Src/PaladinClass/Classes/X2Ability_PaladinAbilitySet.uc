class X2Ability_PaladinAbilitySet extends X2Ability
	config(PaladinClass);

var name BattlefuryAbilityName;
var name HolyStrikeAbilityName;

static function array <X2DataTemplate> CreateTemplates()
{
	// TODO: expose values and strings to config and localization, respectively, sort of like this:
	// var config int ParallaxCooldown;
	// var localized string ParallaxFriendlyName;
	
	local array<X2DataTemplate> Templates;
	Templates.Length = 0;

	// SQUADDIE!
	//Templates.AddItem(PurePassive(default.BattlefuryAbilityName));
	Templates.AddItem(AddHolyStrike());

	`LOG("Paladin Class: Creating templates - " @ string(Templates.Length));
	return Templates;
}

static function X2AbilityTemplate AddHolyStrike(optional name AbilityName = default.HolyStrikeAbilityName)
{
	local X2AbilityTemplate Template;
	local X2AbilityCooldown	Cooldown;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee StandardMelee;
	local X2AbilityTarget_MovingMelee MeleeTarget;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local array<name> SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;	
	Template.CinescriptCameraType = "Ranger_Reaper";
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_swordSlash";
	Template.bHideOnClassUnlock = false;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;
	Template.AbilityConfirmSound = "TacticalUI_SwordConfirm";

	// cooldown
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bConsumeAllPoints = false;
	ActionPointCost.bMoveCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	StandardMelee = new class'X2AbilityToHitCalc_StandardMelee';
	Template.AbilityToHitCalc = StandardMelee;

	// holy strike can only be used over blue-move range
	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	MeleeTarget.MovementRangeAdjustment = 1;
	Template.AbilityTargetStyle = MeleeTarget;

	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';
	//Template.TargetingMethod = class'X2TargetingMethod_HolyStrike';

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// pulling for now - i think this is here to allow bladestorm/reaper stuff, but we're not doing that
	//Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	// Target Conditions
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);

	// Shooter Conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);

	Template.bAllowBonusWeaponEffects = true;
	Template.bSkipMoveStop = true;
	
	// Voice events
	Template.SourceMissSpeech = 'SwordMiss';

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;

	return Template;
}

DefaultProperties
{
	BattlefuryAbilityName="Battlefury"
	HolyStrikeAbilityName="HolyStrike";
}