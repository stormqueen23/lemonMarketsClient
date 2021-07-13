import 'package:lemon_market_client/data/accessToken.dart';
import 'package:lemon_market_client/data/space.dart';
import 'package:lemon_market_client/data/spaceState.dart';
import 'package:lemon_market_client/data/stateInfo.dart';
import 'package:lemon_market_client/clients/lemonClient.dart';
import 'package:lemon_market_client/helper/lemonmarketURLs.dart';
import 'package:logging/logging.dart';

class LemonMarketSpaces {
  final log = Logger('LemonMarketSpaces');
  LemonClient _client;

  LemonMarketSpaces(this._client);

  Future<List<Space>> getSpaces(AccessToken token) async {
    List<Space> result = [];
    String url = LemonMarketURL.BASE_URL+'/spaces/';
    try {
      Map<String, dynamic> decoded = await _client.sendGet(url, token);
      List<dynamic> all = decoded['results'];
      all.forEach((element) {
        Space i = Space.fromJson(element);
        result.add(i);
      });
    } catch (e) {
      log.info(e.toString());
    }
    return result;
  }

  Future<Space?> getSpace(AccessToken token, String uuid) async {
    Space? result;
    String url = LemonMarketURL.BASE_URL+'/spaces/'+uuid;
    try {
      Map<String, dynamic> decoded = await _client.sendGet(url, token);
      result = Space.fromJson(decoded);
    } catch (e) {
      log.info(e.toString());
    }
    return result;
  }

  Future<SpaceState?> getSpaceState(AccessToken token, String uuid) async {
    SpaceState? result;
    String url = LemonMarketURL.BASE_URL+'/spaces/'+uuid+'/state';
    try {
      Map<String, dynamic> decoded = await _client.sendGet(url, token);
      result = SpaceState.fromJson(decoded);
    } catch (e) {
      log.info(e.toString());
    }
    return result;
  }

  Future<StateInfo?> getSpaceInfo(AccessToken token) async {
    StateInfo? result;
    String url = LemonMarketURL.BASE_URL+'/state/';
    try {
      Map<String, dynamic> decoded = await _client.sendGet(url, token);
      result = StateInfo.fromJson(decoded);
    } catch (e) {
      log.info(e.toString());
    }
    return result;
  }
}