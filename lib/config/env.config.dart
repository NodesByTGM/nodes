// ignore_for_file: constant_identifier_names

library regenified;

const isDev = true;
const API_ENDPOINT = isDev
    ? "https://dev.api.nodesafrica.com/api/v1"
    : "https://dev.nodesafrica.com/api/v1";

// const PAYSTACK_PRO_PLAN_SK = "PLN_e11atwl7oyvnajq";
// const PAYSTACK_PRO_ANNUAL_PLAN_SK = "PLN_3f6iseacm5i9fum";
// const PAYSTACK_BUSINESS_PLAN_SK = "PLN_baeodisxfma3vno";
// const PAYSTACK_BUSINESS_ANNUAL_PLAN_SK = "PLN_68xympmt1h631xk";
// const PAYSTACK_SECRET_KEY = "sk_test_933b5ba1d98700c5bd1d06f0533c8a19bfbb7dd6";

const nodeWebsite = "https://dev.api.nodesafrica.com";
const tGMWebsite = "https://thegridmanagement.com";
const paystackCancelActionUrl = "https://www.google.com/";
const paystackCardCallbackUrl = "https://standard.paystack.co/close";
const busMonthlySub = "business";
const busYearlySub = "business-annual";
const talentMonthlySub = "pro";
const talentYearlySub = "pro-annual";

const double proMonthlyAmt = 7900;
const double businessMonthlyAmt = 19800;

const double proYearlyAmt = 89800;
const double businessyearlyAmt = 214800;

paystackCallbackUrl(ref) => "$tGMWebsite/?trxref=$ref&reference=$ref";

const standardTopic = "nodes.standard";
const proTopic = "nodes.pro";
const businessTopic = "nodes.business";


// sk_test_812646584458dfec2bf133db969dd587e34f6ebb