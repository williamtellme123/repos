package resources;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.UriInfo;

// CONTROLLER
//Rest web services 23 - The Param annotations

@Path("/injectdemo")
@Consumes("text/plain")
@Produces("text/plain")
public class InjectDemoResource {

        //    --------------------------------------------------------------------------
        //    KNOWN AS CONTROLLER METHODS THAT CAN TAKE PARAMETERS
        //    --------------------------------------------------------------------------




        //    --------------------------------------------------------------------------
        //    NO PARAM
        //    http://localhost:8080/messenger/webresources/injectdemo/annotations
        //    public String getIt() {
        //        return "Hi there wowzer bowzer!";
        //    }
        //    --------------------------------------------------------------------------




        //    --------------------------------------------------------------------------
        //    MATRIX Param
        //    http://localhost:8080/messenger/webresources/injectdemo/annotations;param=Hello
        //    @GET
        //    @Produces("text/plain")
        //    @Path("annotations")
        //    public String getParamsUsingAnnotations(@MatrixParam("param") String matrixParam)
        //    {
        //        return "Matrix Parameter: " + matrixParam;
        //    }
        //
        //    RESULTS: Matrix Parameter: Hello
        //    --------------------------------------------------------------------------



        //    --------------------------------------------------------------------------
        //    HEADER PARAM values like security and authentication
        //    http://localhost:8080/messenger/webresources/injectdemo/annotations;param=Hello
        //    Header=authSessionID
        //    Value=187Tdsa2Ds45
        //    @GET
        //    @Path("annotations")
        //    public String getParamsUsingAnnotations(@MatrixParam("param") String matrixParam,
        //                                            @HeaderParam("authSessionID") String header)
        //    {
        //        return "Matrix Parameter: " + matrixParam + "   header authSessionID:" + header;
        //    }
        //
        //    RESULTS: Matrix Parameter: Hello   header authSessionID:187Tdsa2Ds45
        //    --------------------------------------------------------------------------




        //    --------------------------------------------------------------------------
        //    COOKIE PARAM
        //    Download POSTMAN REST CLIENT (3.x)
        //    Download POSTMAN INTERCEPTOR and turn it on
        //    Settings: USE POSTMAN PROXY: YES
        //    http://localhost:8080/messenger/webresources/injectdemo/annotations;param=Hello
        //    Header=authSessionID
        //    Value=187Tdsa2Ds45
        //    Header=Cookie
        //    JSESSIONIDe=71fe1b8d55346ca88ea8376c2be4
        @GET
        @Path("annotations")
        public String getParamsUsingAnnotations(@MatrixParam("param") String matrixParam,
                                                @HeaderParam("authSessionID") String header,
                                                @CookieParam("JSESSIONID") String cookie)
        {
               return "Matrix Parameter: " + matrixParam + "   header value:" + header + "   name: " + cookie;
        }
        //
        //    RESULTS: Matrix Parameter: Hello   header value:187Tdsa2Ds45   name: 71fe1b8d55346ca88ea8376c2be4
        //    --------------------------------------------------------------------------



        //    --------------------------------------------------------------------------
        //    KNOWN AS CONTROLLER METHODS THAT CAN INTERPRET CONTEXT AND HTTP HEADERS
        //    --------------------------------------------------------------------------
        //    http://localhost:8080/messenger/webresources/injectdemo/context
        @GET
        @Path("context")
        public String getParamsUsingAnnotations(@Context UriInfo uriInfo,
                                                @Context HttpHeaders headers)
        {
            String path = uriInfo.getAbsolutePath().toString();
            // returns a MAP so convert to String
            String cookies = headers.getCookies().toString();
            return "Path: " + path + "\n" + "Cookies: " + cookies;
        }
        //
        // RESULTS:
        // Path: http://localhost:8080/messenger/webresources/injectdemo/context
        // Cookies: {JSESSIONID=$Version=0;JSESSIONID=71fe1b8d55346ca88ea8376c2be4}





        //    --------------------------------------------------------------------------
        //    KNOWN AS CONTROLLER METHODS THAT CAN GET PARAMETERS FROM A BEANPARAM
        //    create a separate bean with all annotations
        //    then in your resource class you just say beanparam & accept that bean
        //    --------------------------------------------------------------------------
        //
        //   See    MessageFilterBean




}
