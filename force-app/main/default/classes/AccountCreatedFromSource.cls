public class AccountCreatedFromSource {

    public class deserializeResponse{

        public String id;

        public String access_token;

    }

    @future(callout=true)

    public static void createAccountinTargetOrg(String accName, String accId){ 

        String clientId = '3MVG9wt4IL4O5wvLwkz2lH7miZRqZiaaJ0yThkiIvh6XYJzQ2xW1xNuOTFCRdgc7MbpvcuZrL1CoxSVScMhoc';//your consumer Key

        String clientSecret = '1A245EB65DEE88635F3C423C8A6FFC4FDD5BE8814F4326E79BF25844F347FA9B';//your consumer secret

        String username = 'alumala.santhosh@verisk.com';

        String password = 'Welcome77#hSAp38SqkxKyequSoTplhqx9K';

        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        
        Http h = new Http();

        HttpRequest req = new HttpRequest();

        //req.setBody(reqbody);
        req.setBody('grant_type=client_credentials' + '&client_id='+clientId+ '&client_secret='+clientSecret + '&scope=USER');
        
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        req.setMethod('POST');

        req.setEndpoint('https://verisk-f-dev-ed.develop.my.salesforce.com/services/oauth2/token');

        HttpResponse res = h.send(req);
        system.debug('response**' +res);

        deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);

        if(resp1.access_token != null){

            String endPoint = 'https://verisk-f-dev-ed.develop.my.salesforce.com/services/apexrest/createAccount';

            String jsonstr = '{"AccName" : "' + accName + '"}';

            Http h2 = new Http();

            HttpRequest req1 = new HttpRequest();

            req1.setHeader('Authorization','Bearer' + resp1.access_token);

            req1.setHeader('Content-Type','application/json');

            req1.setHeader('accept','application/json');

            req1.setBody(jsonstr);

            req1.setMethod('POST');

            req1.setEndpoint(endPoint);

            HttpResponse res1 = h2.send(req1);

        }

    }

}