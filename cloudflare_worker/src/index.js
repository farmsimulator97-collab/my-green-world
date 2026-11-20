const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization",
};

function json(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders },
  });
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    if (url.pathname === "/health" && request.method === "GET") {
      return json({ ok: true, service: "my-green-world-api", stage: "foundation" });
    }

    // ستُضاف مسارات التعرف والتشخيص بعد تثبيت مزود API وتوثيق طلباته.
    if (url.pathname === "/api/identify" && request.method === "POST") {
      return json({
        ok: false,
        code: "NOT_CONFIGURED",
        message: "خدمة التعرف لم تُربط بعد. ستُفعّل في المرحلة التالية."
      }, 501);
    }

    if (url.pathname === "/api/diagnose" && request.method === "POST") {
      return json({
        ok: false,
        code: "NOT_CONFIGURED",
        message: "خدمة تشخيص الأمراض لم تُربط بعد. ستُفعّل في المرحلة التالية."
      }, 501);
    }

    return json({ ok: false, message: "المسار غير موجود" }, 404);
  },
};
