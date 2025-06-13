///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsCs implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsCs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.cs,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <cs>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsCs _root = this; // ignore: unused_field

	@override 
	TranslationsCs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsCs(meta: meta ?? this.$meta);

	// Translations
	@override String get appTitle => 'Senátor GO';
	@override String get senator => 'Senátor';
	@override late final _TranslationsButtonsCs buttons = _TranslationsButtonsCs._(_root);
	@override late final _TranslationsLocationDialogsCs locationDialogs = _TranslationsLocationDialogsCs._(_root);
	@override String get senatorCollection => 'Kolekce senátorů';
	@override String get numberOfSenators => 'Počet senátorů';
	@override late final _TranslationsFiltersCs filters = _TranslationsFiltersCs._(_root);
	@override late final _TranslationsOnTapMapCs onTapMap = _TranslationsOnTapMapCs._(_root);
	@override String get parliamentaryGroup => 'Poslanecký klub';
	@override String get warning => 'TATO APLIKACE NENÍ OFICIÁLNÍ APLIKÁCÍ SENÁTU ČR';
}

// Path: buttons
class _TranslationsButtonsCs implements TranslationsButtonsEn {
	_TranslationsButtonsCs._(this._root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get findSenator => 'Zjistit senátora v oblasti';
	@override String get showCollection => 'Kolekce senátorů';
	@override String get findOutMoreInformation => 'Zjistit více informací';
}

// Path: locationDialogs
class _TranslationsLocationDialogsCs implements TranslationsLocationDialogsEn {
	_TranslationsLocationDialogsCs._(this._root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsLocationDialogsPositionCs position = _TranslationsLocationDialogsPositionCs._(_root);
	@override late final _TranslationsLocationDialogsNewSenatorCs newSenator = _TranslationsLocationDialogsNewSenatorCs._(_root);
}

// Path: filters
class _TranslationsFiltersCs implements TranslationsFiltersEn {
	_TranslationsFiltersCs._(this._root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get all => 'Vše';
	@override String get prague => 'Praha';
	@override String get brno => 'Brno';
	@override String get ostrava => 'Ostrava';
}

// Path: onTapMap
class _TranslationsOnTapMapCs implements TranslationsOnTapMapEn {
	_TranslationsOnTapMapCs._(this._root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get district => 'Obvod č.';
}

// Path: locationDialogs.position
class _TranslationsLocationDialogsPositionCs implements TranslationsLocationDialogsPositionEn {
	_TranslationsLocationDialogsPositionCs._(this._root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nelze načíst polohu';
	@override String get content => 'Aplikace nemůže načíst vaši polohu. Ověřte, zda máte zapnutou polohu, popřípadě povolte aplikaci přístup k polohovým službám. Senátory také nelze hledat mimo území ČR.';
}

// Path: locationDialogs.newSenator
class _TranslationsLocationDialogsNewSenatorCs implements TranslationsLocationDialogsNewSenatorEn {
	_TranslationsLocationDialogsNewSenatorCs._(this._root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nový Senátor Objeven';
	@override String get content => 'Gratulujeme, byl objeven nový senátor.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsCs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appTitle': return 'Senátor GO';
			case 'senator': return 'Senátor';
			case 'buttons.findSenator': return 'Zjistit senátora v oblasti';
			case 'buttons.showCollection': return 'Kolekce senátorů';
			case 'buttons.findOutMoreInformation': return 'Zjistit více informací';
			case 'locationDialogs.position.title': return 'Nelze načíst polohu';
			case 'locationDialogs.position.content': return 'Aplikace nemůže načíst vaši polohu. Ověřte, zda máte zapnutou polohu, popřípadě povolte aplikaci přístup k polohovým službám. Senátory také nelze hledat mimo území ČR.';
			case 'locationDialogs.newSenator.title': return 'Nový Senátor Objeven';
			case 'locationDialogs.newSenator.content': return 'Gratulujeme, byl objeven nový senátor.';
			case 'senatorCollection': return 'Kolekce senátorů';
			case 'numberOfSenators': return 'Počet senátorů';
			case 'filters.all': return 'Vše';
			case 'filters.prague': return 'Praha';
			case 'filters.brno': return 'Brno';
			case 'filters.ostrava': return 'Ostrava';
			case 'onTapMap.district': return 'Obvod č.';
			case 'parliamentaryGroup': return 'Poslanecký klub';
			case 'warning': return 'TATO APLIKACE NENÍ OFICIÁLNÍ APLIKÁCÍ SENÁTU ČR';
			default: return null;
		}
	}
}

