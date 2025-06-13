///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	String get appTitle => 'Senator GO';
	String get senator => 'Senator';
	late final TranslationsButtonsEn buttons = TranslationsButtonsEn._(_root);
	late final TranslationsLocationDialogsEn locationDialogs = TranslationsLocationDialogsEn._(_root);
	String get senatorCollection => 'Senator collection';
	String get numberOfSenators => 'Number of senators';
	late final TranslationsFiltersEn filters = TranslationsFiltersEn._(_root);
	late final TranslationsOnTapMapEn onTapMap = TranslationsOnTapMapEn._(_root);
	String get parliamentaryGroup => 'Parliamentary group';
	String get warning => 'THIS APP IS NOT AN OFFICIAL APP OF THE SENATE OF CZECHIA';
}

// Path: buttons
class TranslationsButtonsEn {
	TranslationsButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get findSenator => 'Find a senator in the area';
	String get showCollection => 'Senator collection';
	String get findOutMoreInformation => 'Find out more information';
}

// Path: locationDialogs
class TranslationsLocationDialogsEn {
	TranslationsLocationDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsLocationDialogsPositionEn position = TranslationsLocationDialogsPositionEn._(_root);
	late final TranslationsLocationDialogsNewSenatorEn newSenator = TranslationsLocationDialogsNewSenatorEn._(_root);
}

// Path: filters
class TranslationsFiltersEn {
	TranslationsFiltersEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get all => 'All';
	String get prague => 'Prague';
	String get brno => 'Brno';
	String get ostrava => 'Ostrava';
}

// Path: onTapMap
class TranslationsOnTapMapEn {
	TranslationsOnTapMapEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get district => 'District n.';
}

// Path: locationDialogs.position
class TranslationsLocationDialogsPositionEn {
	TranslationsLocationDialogsPositionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Unable to retrieve location';
	String get content => 'The app cannot retrieve your location. Verify that you have location turned on, or allow the app to access location services. Senators cannot be found outside the territory of the Czech Republic.';
}

// Path: locationDialogs.newSenator
class TranslationsLocationDialogsNewSenatorEn {
	TranslationsLocationDialogsNewSenatorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'New Senator Discovered';
	String get content => 'Congratulations, a new senator has been discovered.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appTitle': return 'Senator GO';
			case 'senator': return 'Senator';
			case 'buttons.findSenator': return 'Find a senator in the area';
			case 'buttons.showCollection': return 'Senator collection';
			case 'buttons.findOutMoreInformation': return 'Find out more information';
			case 'locationDialogs.position.title': return 'Unable to retrieve location';
			case 'locationDialogs.position.content': return 'The app cannot retrieve your location. Verify that you have location turned on, or allow the app to access location services. Senators cannot be found outside the territory of the Czech Republic.';
			case 'locationDialogs.newSenator.title': return 'New Senator Discovered';
			case 'locationDialogs.newSenator.content': return 'Congratulations, a new senator has been discovered.';
			case 'senatorCollection': return 'Senator collection';
			case 'numberOfSenators': return 'Number of senators';
			case 'filters.all': return 'All';
			case 'filters.prague': return 'Prague';
			case 'filters.brno': return 'Brno';
			case 'filters.ostrava': return 'Ostrava';
			case 'onTapMap.district': return 'District n.';
			case 'parliamentaryGroup': return 'Parliamentary group';
			case 'warning': return 'THIS APP IS NOT AN OFFICIAL APP OF THE SENATE OF CZECHIA';
			default: return null;
		}
	}
}

