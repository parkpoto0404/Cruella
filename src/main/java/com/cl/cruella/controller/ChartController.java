package com.cl.cruella.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cl.cruella.dto.RevenueDto;
import com.cl.cruella.service.ChartService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/chart")
@RequiredArgsConstructor
public class ChartController {

    private final ChartService chartService;

    @GetMapping("/chart.do")
    public String chartPage(Model model) {
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        model.addAttribute("currentDate", currentDate.format(formatter));
        return "chart/chart";
    }

    @ResponseBody
    @PostMapping("/teamSales.do")
    public String getDeptIncomeByMonth(@RequestBody Map<String, String> params) {
        List<RevenueDto> list = chartService.getDeptIncomeByMonth(params);
        return list.stream()
                .map(sales -> {
                    Gson gson = new Gson();
                    JsonObject object = new JsonObject();
                    object.addProperty("deptCode", sales.getDeptCode());
                    object.addProperty("sale", sales.getRvValue());
                    return gson.toJson(object);
                })
                .collect(Collectors.joining(", ", "[", "]"));
    }

    @ResponseBody
    @PostMapping("/monthlySales.do")
    public List<RevenueDto> getMonthlySalesData(@RequestBody Map<String, String> params) {
        String year = params.getOrDefault("year", String.valueOf(LocalDate.now().getYear())); 
        List<RevenueDto> salesData = chartService.getMonthlySalesByYear(year);
        return salesData;
    }
    
    
    @ResponseBody
    @PostMapping("/storeSales.do")
    public List<RevenueDto> getStoreSales(@RequestBody Map<String, String> params) {
        String deptCode = params.get("deptCode");
        String startDate = params.get("startDate");
        String endDate = params.get("endDate");

        return chartService.getStoreSales(deptCode, startDate, endDate);
    }




}
