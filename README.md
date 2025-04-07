<div style="display:flex;gap:1%;margin-bottom:20px">
  <h1 style="border:none">Open SmartCity Map Module of the Open SmartCity App</h1>
  <img height="100px" alt="logo" src="Docs/img/logo.svg">
</div>

## Important Notice

- **Read-Only Repository:** This GitHub repository is a mirror of our project's source code. It is not intended for direct changes.
- **Contribution Process:** Once our Open Code platform is live, any modifications, improvements, or contributions must be made through our [Open Code](https://gitlab.opencode.de/) platform. Direct changes via GitHub are not accepted.

---

- [Important Notice](#important-notice)
- [Changelog 📝](#changelog-)
- [License](#license)

<p align="center">
<img src="https://img.shields.io/badge/Platform%20Compatibility%20-ios-red">
<img src="https://img.shields.io/badge/Swift%20Compatibility%20-5.5%20%7C%205.4%20%7C%205.3%20%7C%205.2%20%7C%205.1-blue">
<a href="#"><img src="https://img.shields.io/badge/Swift-Doc-inactive"></a>
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>
</p>

## Features
- [x] List your features

## Requirements

- iOS 13.0+
- Swift 5.0+

### Installation
#### Swift Package Manager
- File > Swift Packages > Add Package Dependency
- Add `URL`
- Select "Up to Next Major" with "VERSION"

#### `SupportingFiles` secrets #####
* copy `Development.xcconfig` and `Production.xcconfig` to `OSCAMap/OSCAMap/SupportingFiles`, these files have to be ignored by git

## `POICategory` schema ##
```json
{
    "results": [
        {
            "objectId": "sport26",
            "name": "Spielplatz",
            "mapTitle": "Spielpl\u00e4tze",
            "status": "normal",
            "iconName": "Icon_Erholung_Spielplatz",
            "iconPath": "https://geoportal.solingen.de/buergerservice1/ol3/solingen_icons",
            "iconMimetype": ".png",
            "symbolName": "XE_Erholung_Spielplatz",
            "symbolPath": "https://geoportal.solingen.de/buergerservice1/ol3/solingen_symbols",
            "symbolMimetype": ".png",
            "position": 10,
            "showCategory": "true",
            "categoryVersion": "1.0",
            "metathema": "Spielpl\u00e4tze",
            "metaquelle": "Kombination aus Excel Stadtdienst Sport und Lotus Notes Verzeichnisdatenbank",
            "metainfodatum": "20220215054917",
            "showFilter": "true",
            "filterFields": [
                {
                    "title": "Typ",
                    "field": "filter_spielplatztyp"
                },
                {
                    "title": "geeignet f\u00fcr Altersgruppe",
                    "field": "filter_altersgruppe"
                }
            ],
            "createdAt": "2022-02-15T08:32:38.746Z",
            "updatedAt": "2022-02-23T08:40:33.703Z"
        }
    ]
}
```
## `Poi` schema ##
```json
{
	"results": [
	{
            "objectId": "bf3f2e19-3944-4dd6-8b4a-d0330f27e787",
            "name": "Spielplatz Dorperhof 1 Typ C",
            "city": "Solingen",
            "district": "Burg-H\u00f6hscheid",
            "poiCategory": "sport26",
            "showUserGeneratedContent": false,
            "showRouteTo": false,
            "routeType": "car",
            "geopoint": {
                "__type": "GeoPoint",
                "latitude": 51.15459590258795,
                "longitude": 7.121672679031185
            },
            "details": [
                {
                    "type": "text",
                    "title": "Ausstattung",
                    "value": "Rutsche",
                    "position": 900
                },
                {
                    "type": "text",
                    "title": "Ausstattung",
                    "value": "Sandkasten",
                    "position": 901
                },
                {
                    "type": "text",
                    "title": "Ausstattung",
                    "value": "Wipptier",
                    "position": 902
                },
                {
                    "type": "text",
                    "title": "Typ",
                    "value": "Spielplatz",
                    "position": 400,
                    "iconName": "infoicon",
                    "iconPath": "https://geoportal.solingen.de/buergerservice1/ol3/solingen_icons",
                    "iconMimetype": ".png",
                    "symbolName": "XE_Erholung_Spielplatz",
                    "symbolPath": "https://geoportal.solingen.de/buergerservice1/ol3/solingen_symbols",
                    "symbolMimetype": ".png",
                    "filterField": "filter_spielplatztyp"
                },
                {
                    "type": "http",
                    "title": "Homepage",
                    "value": "https://www.solingen.de/de/sport/257-dorperhof-typ-c/",
                    "position": 500
                },
                {
                    "type": "text",
                    "title": "Name",
                    "value": "Spielplatz Dorperhof 1",
                    "position": 100
                },
                {
                    "type": "text",
                    "title": "geeignet f\u00fcr Altersgruppe",
                    "value": "Kleinkinder",
                    "position": 300,
                    "iconName": "infoicon",
                    "iconPath": "https://geoportal.solingen.de/buergerservice1/ol3/solingen_icons",
                    "iconMimetype": ".png",
                    "symbolName": "XE_Erholung_Spielplatz_Kleinkinder",
                    "symbolPath": "https://geoportal.solingen.de/buergerservice1/ol3/solingen_symbols",
                    "symbolMimetype": ".png",
                    "filterField": "filter_altersgruppe"
                }
            ],
            "images": [
                {
                    "imageName": "1300-240-257_W",
                    "imagePath": "https://geoportal.solingen.de/buergerservice1/ressourcen/spielplaetze/",
                    "imageMimetype": ".jpg",
                    "text": "kommt aus exif",
                    "relevance": 1,
                    "accessibilityHint": "Foto eines Spielplatzes"
                },
                {
                    "imageName": "1300-240-257_N",
                    "imagePath": "https://geoportal.solingen.de/buergerservice1/ressourcen/spielplaetze/",
                    "imageMimetype": ".jpg",
                    "text": "kommt aus exif",
                    "relevance": 1,
                    "accessibilityHint": "Foto eines Spielplatzes"
                },
                {
                    "imageName": "1300-240-257_S",
                    "imagePath": "https://geoportal.solingen.de/buergerservice1/ressourcen/spielplaetze/",
                    "imageMimetype": ".jpg",
                    "text": "kommt aus exif",
                    "relevance": 1,
                    "accessibilityHint": "Foto eines Spielplatzes"
                },
                {
                    "imageName": "1300-240-257_O",
                    "imagePath": "https://geoportal.solingen.de/buergerservice1/ressourcen/spielplaetze/",
                    "imageMimetype": ".jpg",
                    "text": "kommt aus exif",
                    "relevance": 1,
                    "accessibilityHint": "Foto eines Spielplatzes"
                }
            ],
            "createdAt": "2022-02-15T08:48:10.187Z",
            "updatedAt": "2022-02-15T08:48:10.187Z"
        }
   ]
}

```
## `OSCAPoi` Endpoint ##
```console
curl -X GET \
 -H "X-Parse-Application-Id: {Application-Id}" \
 -H "X-Parse-REST-API-Key: {API-Key}" \
 'https://parse-dev.solingen.de/classes/POI' \
 | python3 -m json.tool
```
## `OSCAPoiCategory` Endpoint ##
```console
 curl -X GET \
 -H "X-Parse-Application-Id: {Application-Id}" \
 -H "X-Parse-REST-API-Key: {API-Key}" \
 'https://parse-dev.solingen.de/classes/POICategory' \
 | python3 -m json.tool
```
## Network Mockup ##
### framework library project ###
* setup `OTHER_SWIFT_FLAGS` for `DEBUG`: `'-D MOCKNETWORK'` in `OSCAMap`-target
### SPM `Package.swift` ###
* define `MOCKNETWORK` in `OSCAMap`-target's `swiftSettings`
## Other
### Developments and Tests

Any contributing and pull requests are warmly welcome. However, before you plan to implement some features or try to fix an uncertain issue, it is recommended to open a discussion first. It would be appreciated if your pull requests could build and with all tests green.

## Changelog 📝

Please see the [Changelog](CHANGELOG.md).

## License

OSCA Server is licensed under the [Open SmartCity License](LICENSE.md).
