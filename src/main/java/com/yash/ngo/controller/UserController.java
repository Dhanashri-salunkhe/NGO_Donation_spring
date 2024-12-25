package com.yash.ngo.controller;

import com.yash.ngo.command.LoginCommand;
import com.yash.ngo.command.UserCommand;
import com.yash.ngo.domain.Campaign;
import com.yash.ngo.domain.User;
import com.yash.ngo.exception.UserBlockedException;
import com.yash.ngo.service.CampaignService;
import com.yash.ngo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private CampaignService campaignService;



    @RequestMapping(value = {"/", "/index"})
    public String showIndexPage(Model model) {
        List<Campaign> campaigns = campaignService.getAllCampaigns();
        for (Campaign campaign : campaigns) {
            if (campaign.getImage() != null) {
                campaign.setImageBase64(campaign.getImageBase64());
            }
        }
        model.addAttribute("campaigns", campaigns);
        return "index"; // Ensure this matches your JSP file name
    }


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginPage(Model model) {
        model.addAttribute("command", new LoginCommand());
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String handleLogin(@ModelAttribute("command") LoginCommand cmd,
                              Model model,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        try {
            User loggedInUser = userService.login(cmd.getLoginName(), cmd.getPassword());

            if (loggedInUser == null) {
                model.addAttribute("err", "Login failed. Please enter valid credentials.");
                return "login";
            }  else {
            // Success
            addUserInSession(loggedInUser, session);


            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                return "redirect:" + redirectUrl;
            }

            if (loggedInUser.getRole().equals(UserService.ROLE_ADMIN)) {
                return "redirect:admin_dashboard";
            } else if (loggedInUser.getRole().equals(UserService.ROLE_USER)) {
                return "redirect:campaign";
            } else {
                model.addAttribute("err", "Invalid user role.");
                return "login";
            }
        }
        } catch (UserBlockedException ex) {
            model.addAttribute("err", ex.getMessage());
            return "login";
        }
    }

//    @RequestMapping(value = "/login", method = RequestMethod.POST)
//    public String handleLogin(@ModelAttribute("command") LoginCommand cmd, Model model, HttpSession session) {
//        try {
//            User loggedInUser = userService.login(cmd.getLoginName(), cmd.getPassword());
//
//            if (loggedInUser == null) {
//                model.addAttribute("err", "Login failed. Please enter valid credentials.");
//                return "login";
//            } else {
//                // Success
//                if (loggedInUser.getRole().equals(UserService.ROLE_ADMIN)) {
//                    addUserInSession(loggedInUser, session);
//                    return "redirect:admin_dashboard";
//                } else if (loggedInUser.getRole().equals(UserService.ROLE_USER)) {
//                    addUserInSession(loggedInUser, session);
//                    return "redirect:campaign";
//                } else {
//                    model.addAttribute("err", "Invalid user role.");
//                    return "login";
//                }
//            }
//        } catch (UserBlockedException ex) {
//            model.addAttribute("err", ex.getMessage());
//            return "login";
//        }
//    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String showRegistrationForm(Model model) {
        UserCommand cmd = new UserCommand();
        model.addAttribute("command", cmd);
        return "register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerUser(@ModelAttribute("command") UserCommand cmd, Model model, RedirectAttributes redirectAttributes,HttpSession session) {
        try {
            User user = cmd.getUser();
            user.setRole(UserService.ROLE_USER);
            user.setLoginStatus(UserService.LOGIN_STATUS_ACTIVE);
            userService.register(user);

            addUserInSession(user, session);

            // Add a flash message for success
            redirectAttributes.addFlashAttribute("successMessage", "Registration successful! Please login to continue.");
            return "redirect:campaign"; // Redirect to login page after successful registration
        } catch (DuplicateKeyException e) {
            model.addAttribute("err", "Username is already registered. Please select another username.");
            return "register";
        }
    }

    @RequestMapping(value = {"/logout"})
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:index?act=lo";
    }

    @RequestMapping(value = "/user_dashboard")
    public String userDashboard() {
        return "dashboard_user";
    }

    @RequestMapping(value = "/about")
    public String about() {
        return "about";
    }

    @RequestMapping(value = "/impact")
    public String showCampaigns(Model model) {
        List<Campaign> campaigns = campaignService.getAllCampaigns();
        for (Campaign campaign : campaigns) {
            if (campaign.getImage() != null) {
                campaign.setImageBase64(campaign.getImageBase64());
            }
        }
        model.addAttribute("campaigns", campaigns);
        return "impact";
    }

    @RequestMapping(value = "/admin_dashboard")
    public String adminDashboard() {
        return "dashboard_admin";
    }

    @RequestMapping(value = "/donation_form")
    public String showDonationForm() {
        return "donation_form";
    }

//    @RequestMapping(value = "/campaign")
//    public String campaign() {
//        return "campaign";
//    }

//    @RequestMapping(value = "/Campaign_Details")
//    public String Campaign_Details() {
//        return "Campaign_Details";
//    }



    @GetMapping("/users") public String listUsers(Model model) {
        try {
            List<User> userList = userService.getUserList();
            model.addAttribute("userList", userList);
            return "users";
        } catch (Exception e) {
            model.addAttribute("error", "Error fetching users: " + e.getMessage());
            return "error";

        }
    }


    private void addUserInSession(User user, HttpSession session) {
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("role", user.getRole());
        session.setAttribute("currentUser", user);

    }
}