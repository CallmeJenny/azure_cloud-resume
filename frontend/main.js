window.addEventListener('DOMContentLoaded', (event) =>{
    getVisitCount();
})

const functionApiURL = "https://getvisitorcount-cloudresume.azurewebsites.net/api/VisitorCounter?code=Z7MIFSpHtURFtJCCdNJ7vkTksoPbLlH4e0UE4FN_7mxNAzFuJH5FWQ=="
const localFunctionApi = "http://localhost:7071/api/VisitorCounter";

const getVisitCount = () => {
    let visitorCount = 30;
    fetch(functionApiURL).then(response => {
        return response.json()
    }).then(response =>{
        console.log("Website called function API.");
        visitorCount = response;
        document.getElementById("counter").innerText = visitorCount;
    }).catch(function(error){
        console.log(error);
    });
    return visitorCount;
}
