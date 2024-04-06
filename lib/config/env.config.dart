// ignore_for_file: constant_identifier_names

library regenified;

const isDev = true;
const API_ENDPOINT = isDev
    ? "https://nodes-server-v1.onrender.com/api/v1"
    : "https://nodes-api.thegridmanagement.com/v1";

// const PAYSTACK_PRO_PLAN_SK = "PLN_e11atwl7oyvnajq";
// const PAYSTACK_PRO_ANNUAL_PLAN_SK = "PLN_3f6iseacm5i9fum";
// const PAYSTACK_BUSINESS_PLAN_SK = "PLN_baeodisxfma3vno";
// const PAYSTACK_BUSINESS_ANNUAL_PLAN_SK = "PLN_68xympmt1h631xk";
// const PAYSTACK_SECRET_KEY = "sk_test_933b5ba1d98700c5bd1d06f0533c8a19bfbb7dd6";

const tGMWebsite = "https://thegridmanagement.com";
const paystackCancelActionUrl = "https://www.google.com/";
const paystackCardCallbackUrl = "https://standard.paystack.co/close";
const busMonthlySub = "business";
const busYearlySub = "business-annual";
const talentMonthlySub = "pro";
const talentYearlySub = "pro-annual";

paystackCallbackUrl(ref) => "$tGMWebsite/?trxref=$ref&reference=$ref";
